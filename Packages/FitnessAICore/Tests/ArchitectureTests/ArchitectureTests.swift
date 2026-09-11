import Application
import Contracts
import Domain
import Testing

@Test("Seed modules wire inward without defining product data")
func seedModulesWireInward() {
    #expect(ContractSeed.schemaGeneration == 0)
    #expect(ApplicationSeed().validateWiring() == DomainSeed())
}
