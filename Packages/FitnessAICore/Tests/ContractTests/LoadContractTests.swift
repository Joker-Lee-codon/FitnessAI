import Contracts
import Foundation
import Testing

@Suite("Load contracts")
struct LoadContractTests {
    @Test("Decimal input canonicalizes without binary floating point")
    func decimalCanonicalization() throws {
        #expect(try CanonicalDecimal("1.2300").canonicalValue == "1.23")
        #expect(try CanonicalDecimal("0.000000000001").canonicalValue == "0.000000000001")
        #expect(throws: CanonicalDecimalError.self) { try CanonicalDecimal("1e3") }
        #expect(throws: CanonicalDecimalError.self) { try CanonicalDecimal("-0") }
        #expect(throws: CanonicalDecimalError.self) { try CanonicalDecimal("01") }
    }

    @Test("Entered pounds remain authoritative while kilograms are exactly derived")
    func exactPoundConversion() throws {
        let load = try LoadContract(
            enteredValue: CanonicalDecimal("2.5"),
            unit: .pounds,
            kind: .external,
            basis: .total
        )

        #expect(load.enteredValue?.canonicalValue == "2.5")
        #expect(load.unit == .pounds)
        #expect(try load.canonicalKilograms()?.canonicalValue == "1.133980925")
    }

    @Test("Non-mass kinds require explicit empty value semantics")
    func nonMassValidation() throws {
        let timed = try LoadContract(enteredValue: nil, unit: nil, kind: .timed, basis: .notApplicable)
        #expect(try timed.canonicalKilograms() == nil)

        #expect(throws: LoadContractError.self) {
            try LoadContract(enteredValue: CanonicalDecimal("10"), unit: .kilograms, kind: .timed, basis: .total)
        }
    }

    @Test("Semantically different load kinds and bases cannot be compared")
    func incomparableLoads() throws {
        let total = try LoadContract(enteredValue: CanonicalDecimal("10"), unit: .kilograms, kind: .external, basis: .total)
        let perSide = try LoadContract(enteredValue: CanonicalDecimal("5"), unit: .kilograms, kind: .external, basis: .perSide)
        let assisted = try LoadContract(enteredValue: CanonicalDecimal("10"), unit: .kilograms, kind: .assisted, basis: .total)

        #expect(throws: LoadContractError.self) { try total.compareCanonicalMass(to: perSide) }
        #expect(throws: LoadContractError.self) { try total.compareCanonicalMass(to: assisted) }
    }

    @Test("Decoding cannot bypass semantic validation or substitute a partial value")
    func strictDecoding() {
        let invalidCombination = #"{"enteredValue":"10","unit":"kilograms","kind":"timed","basis":"total"}"#
        let partial = #"{"kind":"external"}"#
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(LoadContract.self, from: Data(invalidCombination.utf8))
        }
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(LoadContract.self, from: Data(partial.utf8))
        }
    }
}
