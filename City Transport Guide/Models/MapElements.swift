//
//  MapElements.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

//   let mapElements = try? JSONDecoder().decode(MapElements.self, from: jsonData)

import Foundation
import UIKit
import Kingfisher

// MARK: - MapElement
struct MapElement: Codable {
    
    var markerDescription: String {
        var descriptionComponents: [String] = []
        if let resourceType = resourceType, resourceType.rawValue != "MOPED" { descriptionComponents.append("Tipo: \(resourceType.rawValue)")}
        if let availableResources = availableResources { descriptionComponents.append("Vehiculos disponibles: \(availableResources)") }
        if let spacesAvailable = spacesAvailable { descriptionComponents.append("Espacios disponibles \(spacesAvailable)") }
        if let range = range { descriptionComponents.append("Autonomía: \(range) km") }
        if station != nil { descriptionComponents.append("Estación de bicis") }
        if let licencePlate = licencePlate { descriptionComponents.append("Matrícula: \(licencePlate)") }
        if let bikesAvailable = bikesAvailable { descriptionComponents.append("Bicis disponibles: \(bikesAvailable)" ) }
        if let helmets = helmets { descriptionComponents.append("Cascos: \(helmets)") }

        return descriptionComponents.joined(separator: "\n")
    }
    var markerTitle : String {
        var title = name
        if let resourceType = resourceType, resourceType.rawValue == "MOPED" {
            title = "Patinete eléctrico"
            
        }
        let regexPattern = "\\d+:M\\d+"
        if let _ = id.range(of: regexPattern, options: .regularExpression) {
            title = title.localizedCapitalized
        }
        return title
    }
    var markerImage: UIImage? {
        var imageName = "" // Default image name
        if let resourceType = resourceType, resourceType.rawValue == "MOPED" {
            imageName = "scooter"
        } else if let idRange = id.range(of: "\\d+:M\\d+", options: .regularExpression) {
            // Matches a Metro station ID pattern
            imageName = "metro"
        }else if let station = station, station {
            imageName = "bicycle"
        }
        return UIImage(named: imageName)?.kf.resize(to: CGSize(width: 36, height: 36))
    }
    
     

    
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

// For tests

extension MapElement {
    init(id: String, name: String, x: Double, y: Double, companyZoneID: Int) {
        self.init(
            id: id,
            name: name,
            x: x,
            y: y,
            scheduledArrival: nil,
            locationType: nil,
            taxable: false,
            companyZoneID: companyZoneID,
            lat: nil,
            lon: nil,
            licencePlate: nil,
            range: nil,
            helmets: nil,
            resourceImageID: nil,
            resourceURL: nil,
            resourcesImagesUrls: nil,
            realTimeData: nil,
            resourceType: nil,
            station: nil,
            availableResources: nil,
            spacesAvailable: nil,
            allowDropoff: nil,
            bikesAvailable: nil
        )
    }
}


typealias MapElements = [MapElement]
