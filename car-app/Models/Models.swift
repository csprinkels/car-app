import Foundation

public struct CarMake: Identifiable, Hashable {
    public let id = UUID()
    public let name: String
    public let models: [CarModel]
    public let logoName: String
    
    public init(name: String, models: [CarModel], logoName: String) {
        self.name = name
        self.models = models
        self.logoName = logoName
    }
}

public struct CarModel: Identifiable, Hashable {
    public let id = UUID()
    public var name: String
    public let year: Int
    public let modelPath: String
    
    public init(name: String, year: Int, modelPath: String) {
        self.name = name
        self.year = year
        self.modelPath = modelPath
    }
}

// Sample data
public let carMakes = [
    CarMake(name: "Toyota", models: [
        CarModel(name: "Camry", year: 2024, modelPath: "toyota_camry_2024"),
        CarModel(name: "Corolla", year: 2024, modelPath: "toyota_corolla_2024"),
        CarModel(name: "GR86", year: 2024, modelPath: "toyota_gr86_2024")
    ], logoName: "toyota_logo"),
    
    CarMake(name: "Honda", models: [
        CarModel(name: "Civic", year: 2024, modelPath: "honda_civic_2024"),
        CarModel(name: "Accord", year: 2024, modelPath: "honda_accord_2024"),
        CarModel(name: "CR-V", year: 2024, modelPath: "honda_crv_2024")
    ], logoName: "honda_logo")
] 
