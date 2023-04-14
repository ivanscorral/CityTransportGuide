// APIManager.swift
// City Transport Guide
//
// Created by Ivan Sanchez on 12/4/23.
//

import Foundation
import Alamofire
import CoreLocation

protocol APIManagerProtocol {
    func getResources(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D, completion: @escaping (Result<[MapElement], Error>) -> Void)
}


class APIManager: APIManagerProtocol {
    static let shared = APIManager()
    private init() {}

    func getResources(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D, completion: @escaping (Result<[MapElement], Error>) -> Void) {
        let urlString = "https://apidev.meep.me/tripplan/api/v1/routers/lisboa/resources?lowerLeftLatLon=\(lowerLeftLatLon.latitude),\(lowerLeftLatLon.longitude)&upperRightLatLon=\(upperRightLatLon.latitude),\(upperRightLatLon.longitude)"
        let headers: HTTPHeaders = [
            "User-Agent": "Meep/iOS/1.0.0",
            "Accept": "application/json"
        ]
        
        AF.request(urlString, method: .get, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let mapElements = try JSONDecoder().decode(MapElements.self, from: data)
                    completion(.success(mapElements))
                } catch {
                    do {
                        let apiError = try JSONDecoder().decode(APIError.self, from: data)
                        completion(.failure(apiError))
                    } catch let decodingError {
                        completion(.failure(decodingError))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
