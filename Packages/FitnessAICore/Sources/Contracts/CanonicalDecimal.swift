import Foundation

public enum CanonicalDecimalError: Error, Equatable, Sendable {
    case invalidSyntax
    case tooManySignificantDigits(maximum: Int)
    case tooManyFractionDigits(maximum: Int)
}

/// A base-ten value whose wire representation never passes through binary floating point.
public struct CanonicalDecimal: Codable, Equatable, Hashable, Sendable {
    public let canonicalValue: String

    public init(_ source: String, maxFractionDigits: Int = 12) throws {
        guard !source.isEmpty, maxFractionDigits >= 0 else {
            throw CanonicalDecimalError.invalidSyntax
        }

        let negative = source.first == "-"
        let unsigned = negative ? String(source.dropFirst()) : source
        let parts = unsigned.split(separator: ".", omittingEmptySubsequences: false)
        guard parts.count <= 2,
              let integer = parts.first,
              !integer.isEmpty,
              integer.utf8.allSatisfy({ (48...57).contains($0) }),
              integer == "0" || integer.first != "0"
        else {
            throw CanonicalDecimalError.invalidSyntax
        }

        let fraction = parts.count == 2 ? String(parts[1]) : ""
        guard parts.count == 1 || (!fraction.isEmpty && fraction.utf8.allSatisfy({ (48...57).contains($0) })) else {
            throw CanonicalDecimalError.invalidSyntax
        }
        guard fraction.count <= maxFractionDigits else {
            throw CanonicalDecimalError.tooManyFractionDigits(maximum: maxFractionDigits)
        }

        let digits = String(integer) + fraction
        let significantDigits = digits.drop(while: { $0 == "0" }).count
        guard significantDigits <= 28 else {
            throw CanonicalDecimalError.tooManySignificantDigits(maximum: 28)
        }

        let trimmedFraction = fraction.reversed().drop(while: { $0 == "0" }).reversed()
        let magnitude = trimmedFraction.isEmpty
            ? String(integer)
            : "\(integer).\(String(trimmedFraction))"
        guard magnitude != "0" || !negative else {
            throw CanonicalDecimalError.invalidSyntax
        }

        canonicalValue = negative ? "-\(magnitude)" : magnitude
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let source = try container.decode(String.self)
        do {
            try self.init(source)
        } catch {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected a canonical base-ten decimal string"
            )
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(canonicalValue)
    }

    var decimalValue: Decimal {
        Decimal(string: canonicalValue, locale: Locale(identifier: "en_US_POSIX"))!
    }

    static func derived(_ value: Decimal, maximumFractionDigits: Int = 20) throws -> Self {
        var value = value
        var rounded = Decimal()
        NSDecimalRound(&rounded, &value, maximumFractionDigits, .plain)
        return try Self(
            NSDecimalString(&rounded, Locale(identifier: "en_US_POSIX")),
            maxFractionDigits: maximumFractionDigits
        )
    }
}
