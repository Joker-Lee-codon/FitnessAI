import Foundation

public enum LoadUnit: String, Codable, CaseIterable, Sendable {
    case kilograms
    case pounds
}

public enum LoadKind: String, Codable, CaseIterable, Sendable {
    case external
    case bodyweight
    case assisted
    case unloaded
    case timed
    case nonComparable

    var representsMass: Bool {
        self == .external || self == .bodyweight || self == .assisted
    }
}

public enum LoadBasis: String, Codable, CaseIterable, Sendable {
    case total
    case perSide
    case notApplicable
}

public enum LoadContractError: Error, Equatable, Sendable {
    case massRequiresValueAndUnit
    case massRequiresApplicableBasis
    case nonMassRequiresEmptyValue
    case nonMassRequiresNotApplicableBasis
    case incomparableSemantics
}

public struct LoadContract: Codable, Equatable, Hashable, Sendable {
    public let enteredValue: CanonicalDecimal?
    public let unit: LoadUnit?
    public let kind: LoadKind
    public let basis: LoadBasis

    public init(
        enteredValue: CanonicalDecimal?,
        unit: LoadUnit?,
        kind: LoadKind,
        basis: LoadBasis
    ) throws {
        if kind.representsMass {
            guard enteredValue != nil, unit != nil else {
                throw LoadContractError.massRequiresValueAndUnit
            }
            guard basis != .notApplicable else {
                throw LoadContractError.massRequiresApplicableBasis
            }
        } else {
            guard enteredValue == nil, unit == nil else {
                throw LoadContractError.nonMassRequiresEmptyValue
            }
            guard basis == .notApplicable else {
                throw LoadContractError.nonMassRequiresNotApplicableBasis
            }
        }

        self.enteredValue = enteredValue
        self.unit = unit
        self.kind = kind
        self.basis = basis
    }

    public func canonicalKilograms() throws -> CanonicalDecimal? {
        guard let enteredValue, let unit else { return nil }
        switch unit {
        case .kilograms:
            return enteredValue
        case .pounds:
            let poundsToKilograms = Decimal(string: "0.45359237", locale: Locale(identifier: "en_US_POSIX"))!
            return try CanonicalDecimal.derived(enteredValue.decimalValue * poundsToKilograms)
        }
    }

    public func compareCanonicalMass(to other: Self) throws -> ComparisonResult {
        guard kind.representsMass,
              kind == other.kind,
              basis == other.basis,
              let lhs = try canonicalKilograms(),
              let rhs = try other.canonicalKilograms()
        else {
            throw LoadContractError.incomparableSemantics
        }
        return NSDecimalNumber(decimal: lhs.decimalValue).compare(NSDecimalNumber(decimal: rhs.decimalValue))
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            try self.init(
                enteredValue: container.decodeIfPresent(CanonicalDecimal.self, forKey: .enteredValue),
                unit: container.decodeIfPresent(LoadUnit.self, forKey: .unit),
                kind: container.decode(LoadKind.self, forKey: .kind),
                basis: container.decode(LoadBasis.self, forKey: .basis)
            )
        } catch let error as LoadContractError {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Invalid load contract combination: \(error)"
            ))
        }
    }

    enum CodingKeys: String, CodingKey {
        case enteredValue
        case unit
        case kind
        case basis
    }
}
