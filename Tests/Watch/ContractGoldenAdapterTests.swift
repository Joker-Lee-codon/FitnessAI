import ContractFixtureSupport
import Contracts
import XCTest

final class WatchContractGoldenAdapterTests: XCTestCase {
    func testSharedGoldenCorpusOnWatchRuntime() throws {
        let corpus = try ContractGoldenCorpus.load()
        XCTAssertEqual(corpus.profile, CanonicalEnvelope.profileIdentifier)
        XCTAssertEqual(corpus.digestAlgorithm, ContractDigest.algorithmIdentifier)
        XCTAssertEqual(corpus.canonical.count, 3)
        XCTAssertEqual(corpus.loads.count, LoadKind.allCases.count)
        XCTAssertEqual(
            try ContractDigest.create(for: CanonicalEnvelope(content: .string("fact"))).hex,
            corpus.canonical[0].digest
        )
    }
}
