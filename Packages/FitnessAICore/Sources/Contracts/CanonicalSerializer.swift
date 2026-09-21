import Foundation

public struct CanonicalSerializer: Sendable {
    public init() {}

    public func serialize(_ value: CanonicalValue) throws -> Data {
        Data(try render(value).utf8)
    }

    private func render(_ value: CanonicalValue) throws -> String {
        switch value {
        case .null:
            return "null"
        case let .bool(value):
            return value ? "true" : "false"
        case let .string(value):
            return quote(normalize(value))
        case let .integer(value):
            return String(value)
        case let .decimal(value):
            return value.canonicalValue
        case let .array(values):
            return "[" + (try values.map(render).joined(separator: ",")) + "]"
        case let .object(members):
            var normalized: [(key: String, value: CanonicalValue)] = []
            var keys = Set<String>()
            for member in members {
                let key = normalize(member.key)
                guard keys.insert(key).inserted else {
                    throw CanonicalizationError.duplicateNormalizedKey(key)
                }
                normalized.append((key, member.value))
            }
            normalized.sort {
                Array($0.key.utf8).lexicographicallyPrecedes(Array($1.key.utf8))
            }
            return "{" + (try normalized.map { member in
                quote(member.key) + ":" + (try render(member.value))
            }.joined(separator: ",")) + "}"
        }
    }

    private func normalize(_ source: String) -> String {
        source.precomposedStringWithCanonicalMapping
    }

    private func quote(_ source: String) -> String {
        var result = "\""
        for scalar in source.unicodeScalars {
            switch scalar.value {
            case 0x22: result += "\\\""
            case 0x5C: result += "\\\\"
            case 0x08: result += "\\b"
            case 0x09: result += "\\t"
            case 0x0A: result += "\\n"
            case 0x0C: result += "\\f"
            case 0x0D: result += "\\r"
            case 0x00...0x1F:
                result += String(format: "\\u%04x", scalar.value)
            default:
                result.unicodeScalars.append(scalar)
            }
        }
        result += "\""
        return result
    }
}
