import Contracts
import Testing

@Suite("Version provenance contracts")
struct VersionContractTests {
    @Test("All supported provenance dimensions remain explicit")
    func explicitVersionDimensions() throws {
        let versions = ContractVersions(
            app: try VersionValue("1.2.0"),
            schema: try VersionValue("3"),
            exerciseCatalog: try VersionValue("catalog-2026-09"),
            model: try VersionValue("model-a"),
            supportMatrix: try VersionValue("matrix-4"),
            safetyRulePack: try VersionValue("safety-7"),
            algorithm: try VersionValue("analysis-2"),
            canonicalProfile: try VersionValue("fitnessai-canonical-v1")
        )

        #expect(versions[.exerciseCatalog]?.canonicalValue == "catalog-2026-09")
        #expect(versions[.canonicalProfile]?.canonicalValue == "fitnessai-canonical-v1")
    }

    @Test("Missing recoverable versions become pending and are never defaulted")
    func missingVersionIsPending() throws {
        let expected = try VersionRequirement(
            kind: .exerciseCatalog,
            expected: VersionValue("catalog-2"),
            missingIsRecoverable: true
        )
        let result = expected.evaluate(actual: ContractVersions())

        guard case let .pending(issue) = result else {
            Issue.record("Expected a pending result")
            return
        }
        #expect(issue.code == .missingRequiredVersion)
        #expect(issue.fieldPath == "versions.exerciseCatalog")
        #expect(issue.expectedVersion == "catalog-2")
        #expect(issue.actualVersion == nil)
        #expect(issue.recoverability == .retryAfterDependency)
    }

    @Test("Known incompatible versions become unsupported")
    func incompatibleVersionIsUnsupported() throws {
        let expected = try VersionRequirement(
            kind: .canonicalProfile,
            expected: VersionValue("fitnessai-canonical-v1"),
            missingIsRecoverable: false
        )
        let actual = ContractVersions(canonicalProfile: try VersionValue("fitnessai-canonical-v2"))

        guard case let .unsupported(issue) = expected.evaluate(actual: actual) else {
            Issue.record("Expected an unsupported result")
            return
        }
        #expect(issue.code == .incompatibleVersion)
        #expect(issue.actualVersion == "fitnessai-canonical-v2")
        #expect(issue.recoverability == .notRecoverable)
    }

    @Test("Malformed and contradictory envelopes are rejected with stable metadata")
    func rejectedIssues() {
        let issue = ContractIssue.rejected(
            code: .contradictoryEnvelope,
            fieldPath: "digest.algorithm"
        )
        #expect(issue.code.rawValue == "contradictory_envelope")
        #expect(issue.fieldPath == "digest.algorithm")
        #expect(issue.expectedVersion == nil)
        #expect(issue.actualVersion == nil)
        #expect(issue.recoverability == .notRecoverable)
    }

    @Test("Version values reject unsafe or ambiguous wire text")
    func malformedVersion() {
        #expect(throws: VersionValueError.self) { try VersionValue("") }
        #expect(throws: VersionValueError.self) { try VersionValue(" v1") }
        #expect(throws: VersionValueError.self) { try VersionValue("版本 1") }
    }
}
