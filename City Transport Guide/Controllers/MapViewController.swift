//
//  MapViewController.swift
//  City Transport Guide
//
//  Created by Ivan Sanchez on 12/4/23.
//

import UIKit
import GoogleMaps

private var mapView: GMSMapView!

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }
    
    private func setupMapView() {
        // Generate random coordinates
        let randomLatitude = Double.random(in: -90...90)
        let randomLongitude = Double.random(in: -180...180)
        let camera = GMSCameraPosition.camera(withLatitude: randomLatitude, longitude: randomLongitude, zoom: 7.0)

        // Initialize and configure mapView
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true

        // Add mapView as a subview
        view.addSubview(mapView)

        // Add 5 random points within a 1km range of the spawn point
        addRandomPoints(latitude: randomLatitude, longitude: randomLongitude, count: 15, range: 11000)
    }

    private func addRandomPoints(latitude: Double, longitude: Double, count: Int, range: Double) {
        for _ in 1...count {
            // Calculate random offset for latitude and longitude
            let latOffset = Double.random(in: -range...range) / 111111.0 // 1 degree latitude ~= 111.111km
            let lngOffset = Double.random(in: -range...range) / (111111.0 * cos(latitude))

            // Create random coordinates
            let randomLatitude = latitude + latOffset
            let randomLongitude = longitude + lngOffset

            // Create a marker and add it to the mapView
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
            marker.map = mapView
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
