//  MapViewController.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    private var mapView: GMSMapView!
    private var displayedMarkers: [MapMarker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        let lowerLeftLatLon = CLLocationCoordinate2D(latitude: 38.711046, longitude: -9.160096) // Ini
        let upperRightLatLon = CLLocationCoordinate2D(latitude: 38.739429, longitude: -9.137115)
        fetchData(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon)
    }
    
    private func setupMapView() {
        let lisboaLatitude = 38.725299
        let lisboaLongitude = -9.150036
        let camera = GMSCameraPosition.camera(withLatitude: lisboaLatitude, longitude: lisboaLongitude, zoom: 16)
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.setMinZoom(12, maxZoom: 17.5) // Limit zoom inoutrange
        view.addSubview(mapView)
    }
    
    func addMarkerWithAnimation(mapElement: MapElement) {
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.75)
            
            let markerPosition = CLLocationCoordinate2D(latitude: mapElement.y, longitude: mapElement.x)
            
            if !self.displayedMarkers.contains(where: { $0.mapElement.id == mapElement.id }) {
                let marker = MapMarker(mapElement: mapElement)
                marker.opacity = 0 // Set initial opacity to 0
                marker.map = self.mapView
                
                // Animate the marker opacity to 1 (fade-in effect)
                CATransaction.setCompletionBlock {
                    marker.opacity = 1
                }
                
                self.displayedMarkers.append(marker)
            }
            
            CATransaction.commit()
        }
    }
    
    
    func fetchData(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D) {
        APIManager.shared.getResources(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let mapElements):
                self.displayedMarkers = self.displayedMarkers.filter { marker in
                    if !self.mapView.projection.contains(marker.position) {
                        marker.map = nil
                        return false
                    }
                    return true
                }
                
                mapElements.forEach { mapElement in
                    self.addMarkerWithAnimation(mapElement: mapElement)
                }
                
            case .failure(let error):
                if let apiError = error as? APIError, let errorDetail = apiError.errors.first {
                    let errorMessage = "Estamos experimentando problemas con el servidor. Por favor, inténtelo más tarde. (Error \(errorDetail.id))"
                    self.displayErrorAlert(errorMessage: errorMessage)
                } else {
                    print("Error: \(error)")
                }
            }
        }
    }
    func displayErrorAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let newLowerLeftLatLon = CLLocationCoordinate2D(latitude: position.target.latitude - 0.014191, longitude: position.target.longitude - 0.01149)
        let newUpperRightLatLon = CLLocationCoordinate2D(latitude: position.target.latitude + 0.014191, longitude: position.target.longitude + 0.01149)
        
        fetchData(lowerLeftLatLon: newLowerLeftLatLon, upperRightLatLon: newUpperRightLatLon)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let mapMarker = marker as? MapMarker else { return false }
        let mapElement = mapMarker.mapElement
        
        // Set navigation bar title to the name of the marker
        self.navigationItem.title = mapElement.name
        
        // Create an instance of InfoView
        let infoView = InfoView(mapElement: mapElement)
        view.addSubview(infoView)
        
        // Set up InfoView constraints
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Add a button to open the location in Google Maps
        let openInGoogleMapsButton = UIButton(type: .system)
        openInGoogleMapsButton.setTitle("Open in Google Maps", for: .normal)
        openInGoogleMapsButton.addTarget(self, action: #selector(openInGoogleMaps), for: .touchUpInside)
        openInGoogleMapsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(openInGoogleMapsButton)
        
        // Set up the button constraints
        NSLayoutConstraint.activate([
            openInGoogleMapsButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 16),
            
            openInGoogleMapsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return true
    }
    
    @objc private func openInGoogleMaps() {
        guard let selectedMarker = mapView.selectedMarker as? MapMarker else { return }
        let mapElement = selectedMarker.mapElement
        
        if let lat = mapElement.lat, let lon = mapElement.lon {
            if let url = URL(string: "comgooglemaps://?q=\(lat),\(lon)&zoom=16") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
}
