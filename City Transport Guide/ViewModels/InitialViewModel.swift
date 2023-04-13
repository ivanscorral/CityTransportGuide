//
//  InitialViewModel.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

	import Foundation

class InitialViewModel {
    var lisbonURL: URL? {
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/41/Lisbon_%2836831596786%29_%28cropped%29.jpg")
    }
    
    func fetchImage(completion: @escaping (Result<URL, Error>) -> Void) {
        // You can replace this URL with the one you want to use for the image
        guard let url = lisbonURL else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        completion(.success(url))
    }
    func navigateToMapViewController() -> MapViewController {
        return MapViewController()
    }
}
