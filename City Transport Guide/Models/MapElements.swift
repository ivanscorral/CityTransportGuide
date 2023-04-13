//
//  MapElements.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//
    
//   let mapElements = try? JSONDecoder().decode(MapElements.self, from: jsonData)

import Foundation

// MARK: - MapElement
struct MapElement: Codable {
    let id, name: String
    let x, y: Double
    let scheduledArrival, locationType: Int?
    let taxable: Bool
    let companyZoneID: Int
    let lat, lon: Double?
    let licencePlate: String?
    let range, helmets: Int?
    let resourceImageID: Resource?
    let resourceURL: String?
    let resourcesImagesUrls: [Resource]?
    let realTimeData: Bool?
    let resourceType: ResourceType?
    let station: Bool?
    let availableResources, spacesAvailable: Int?
    let allowDropoff: Bool?
    let bikesAvailable: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, x, y, scheduledArrival, locationType, taxable
        case companyZoneID = "companyZoneId"
        case lat, lon, licencePlate, range, helmets
        case resourceImageID = "resourceImageId"
        case resourceURL = "resourceUrl"
        case resourcesImagesUrls, realTimeData, resourceType, station, availableResources, spacesAvailable, allowDropoff, bikesAvailable
    }
}

enum Resource: String, Codable {
    case vehicleGenCooltraMoped = "vehicle_gen_cooltra_moped"
}

enum ResourceType: String, Codable {
    case moped = "MOPED"
}

typealias MapElements = [MapElement]
