import ContractFixtureSupport
import Contracts
import XCTest

final class IPhoneContractGoldenAdapterTests: XCTestCase {
    func testSharedGoldenCorpusOnIPhoneRuntime() throws {
        let corpus = try ContractGoldenCorpus.load()
        XCTAssertEqual(corpus.profile, CanonicalEnvelope.profileIdentifier)
        XCTAssertEqual(corpus.digestAlgorithm, ContractDigest.algorithmIdentifier)
        XCTAssertEqual(corpus.canonical.count, 3)
        XCTAssertEqual(Set(corpus.loads.map(\.kind)), Set(LoadKind.allCases.map(\.rawValue)))
        XCTAssertEqual(
            try ContractDigest.create(for: CanonicalEnvelope(content: .string("fact"))).hex,
            corpus.canonical[0].digest
        )
    }
}
