//  MapViewController.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

import UIKit
import GoogleMaps
import MapKit

class MapViewController: UIViewController {
    // MARK: - Properties
    private var mapView: GMSMapView!
    private let viewModel = MapViewModel()
    let lisboaLatitude = 38.725299
    let lisboaLongitude = -9.150036
    let initialLowerLeftLatLon = CLLocationCoordinate2D(latitude: 38.711046, longitude: -9.160096)
    let initialUpperRightLatLon = CLLocationCoordinate2D(latitude: 38.739429, longitude: -9.137115)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        fetchData(lowerLeftLatLon: initialLowerLeftLatLon, upperRightLatLon: initialUpperRightLatLon)
    }
    
    // MARK: - Helper Methods
    private func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: lisboaLatitude, longitude: lisboaLongitude, zoom: 17.4)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.settings.compassButton = true
        mapView.setMinZoom(14, maxZoom: 18.9)
        view.addSubview(mapView)
    }
    
    private func fetchData(lowerLeftLatLon: CLLocationCoordinate2D, upperRightLatLon: CLLocationCoordinate2D) {
        viewModel.fetchData(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let mapElements):
                self.updateDisplayedMarkers(mapView: self.mapView)
                
                mapElements.forEach { mapElement in
                    self.addMarkerWithAnimation(mapElement: mapElement, mapView: self.mapView)
                }
                
            case .failure(let error):
                if let apiError = error as? APIError, let errorDetail = apiError.errors.first {
                    let errorMessage = "Estamos experimentando problemas con el servidor. Por favor, inténtelo más tarde. (Error \(errorDetail.id))"
                    self.displayErrorAlert(errorMessage: errorMessage)
                } else {
                    self.displayErrorAlert(errorMessage: "\(error.localizedDescription), Error: \(error.asAFError?.responseCode ?? -1)")
                }
            }
        }
    }
    
    private func updateDisplayedMarkers(mapView: GMSMapView) {
        viewModel.displayedMarkers = viewModel.displayedMarkers.filter { marker in
            if !mapView.projection.contains(marker.position) {
                marker.map = nil
                return false
            }
            return true
        }
    }
    
    private func addMarkerWithAnimation(mapElement: MapElement, mapView: GMSMapView) {
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setAnimationDuration(1.35)
            
            if !self.viewModel.displayedMarkers.contains(where: { $0.mapElement.id == mapElement.id }) {
                let marker = MapMarker(mapElement: mapElement)
                marker.icon = mapElement.markerImage
                marker.opacity = 0
                marker.map = mapView
                
                marker.title = mapElement.markerTitle
                marker.snippet = mapElement.markerDescription
                
                CATransaction.setCompletionBlock {
                    marker.opacity = 1
                }
                
                self.viewModel.displayedMarkers.append(marker)
            }
            
            CATransaction.commit()
        }
    }
    private func displayErrorAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let newLowerLeftLatLon = CLLocationCoordinate2D(latitude: position.target.latitude - 0.0075, longitude: position.target.longitude - 0.0065)
        let newUpperRightLatLon = CLLocationCoordinate2D(latitude: position.target.latitude + 0.0075, longitude: position.target.longitude + 0.0065)
        fetchData(lowerLeftLatLon: newLowerLeftLatLon, upperRightLatLon: newUpperRightLatLon)
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        guard let mapMarker = marker as? MapMarker else { return }
        
        let alertController = UIAlertController(title: "Abrir en Mapas", message: "¿Desea abrir la ubicación en Mapas?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let location = CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
            
            let regionDistance: CLLocationDistance = 700
            let regionSpan = MKCoordinateRegion(center: location, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "\(mapMarker.title ?? "") \(mapMarker.mapElement.resourceType?.rawValue == "MOPED" ? " - \(mapMarker.mapElement.licencePlate ?? "")" : "" )"
            mapItem.openInMaps(launchOptions: options)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if position.zoom < 14.1 {
            mapView.animate(toZoom: 14.55)
        }
        else if position.zoom > 18.35 {
            mapView.animate(toZoom: 18.35)
        }
    }
}

