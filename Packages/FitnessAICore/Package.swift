// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "FitnessAICore",
    platforms: [.iOS(.v18), .watchOS(.v11), .macOS(.v15)],
    products: [
        .library(name: "FitnessAIContracts", targets: ["Contracts"]),
        .library(name: "FitnessAIDomain", targets: ["Domain"]),
        .library(name: "FitnessAIApplication", targets: ["Application"]),
        .library(name: "FitnessAIPersistencePorts", targets: ["PersistencePorts"]),
        .library(name: "FitnessAISyncContracts", targets: ["SyncContracts"]),
        .library(name: "FitnessAISafetyRules", targets: ["SafetyRules"]),
        .library(name: "FitnessAIAnalysis", targets: ["Analysis"]),
        .library(name: "FitnessAIPersistenceGRDB", targets: ["PersistenceGRDB"]),
    ],
    dependencies: [
        .package(url: "https://github.com/groue/GRDB.swift.git", exact: "7.11.1"),
    ],
    targets: [
        .target(name: "Contracts"),
        .target(name: "Domain", dependencies: ["Contracts"]),
        .target(name: "PersistencePorts", dependencies: ["Domain"]),
        .target(name: "SyncContracts", dependencies: ["Contracts"]),
        .target(name: "SafetyRules", dependencies: ["Domain"]),
        .target(name: "Analysis", dependencies: ["Domain"]),
        .target(
            name: "Application",
            dependencies: ["Domain", "PersistencePorts", "SyncContracts", "SafetyRules", "Analysis"]
        ),
        .target(
            name: "PersistenceGRDB",
            dependencies: ["PersistencePorts", .product(name: "GRDB", package: "GRDB.swift")]
        ),
        .testTarget(name: "ArchitectureTests", dependencies: [
            "Contracts", "Domain", "Application", "PersistencePorts",
            "SyncContracts", "SafetyRules", "Analysis", "PersistenceGRDB",
        ]),
    ]
)
