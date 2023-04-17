# City Transport Guide

## Workflow status
[![iOS starter workflow](https://github.com/ivanscorral/CityTransportGuide/actions/workflows/ios.yml/badge.svg)](https://github.com/ivanscorral/CityTransportGuide/actions/workflows/ios.yml)

*Note: GitHub does not yet support Xcode 14.3 and iOS 16.4 so this project will keep failing builds until they add support*

City Transport Guide is an iOS application that helps users explore the public transportation options in the city of Lisbon, Portugal. The app displays a map with custom markers for different public transport resources like bikes, scooters, metro stations, and more. Users can tap on a marker to view additional information about each resource, and even open the native Maps app for further navigation.

## Features
- Display a map centered on Lisbon.
- Fetch and display markers for transportation resources (bikes, scooters, metro stations, etc.) from the provided API.
- Show custom icons for each marker based on the companyID of the transportation resource.
- Animate the markers when they appear on the map.
- Update the markers on the map as the user moves around.
- Limit the zoom level to a specific range.
- Display an info window with the name and a short description of the resource when a marker is tapped.
- Open the native Maps app with the selected location when the info window is tapped.
- Handle errors gracefully by showing an error alert with relevant information.

## Screenshots

<img src="https://user-images.githubusercontent.com/17148950/232102301-29e9813f-3b64-4f44-94b8-bb5b06ff2503.png" alt="Launch screen:" width="317" height="688" ></img>
<img src="https://user-images.githubusercontent.com/17148950/231889371-2d586f84-37cf-4f4a-9618-af2d04942a30.png" alt="Main map screen with custom icons"  width="317" height="688" ></img>
<img src="https://user-images.githubusercontent.com/17148950/231889631-40fca119-6729-4405-94ba-e361ca1da67b.png" alt="Detailed view of an item:" width="317" height="688" ></img>
<img src="https://user-images.githubusercontent.com/17148950/231890390-3359c251-a53e-4c54-a496-11ab152b8695.png" alt="Map view of an item:" width="317" height="688" > </img>
<img src="https://i.ibb.co/H2QSFWC/Captura-2023-04-15-a-las-22-04-05.png" width="317" height="688" > </img>
<img src="https://user-images.githubusercontent.com/17148950/232101992-0562ed8d-a636-452b-95bb-093d096288ec.png" alt="Confirmation to open maps" width="317" height="688"> </img>
<img src="https://user-images.githubusercontent.com/17148950/231613998-03a737fe-9a45-420d-9af2-b1c6b59f2610.png" alt="Error handling: " width="317" height="688" > </img>
## How to install  

* Clone the repository
  * ```git clone https://github.com/ivanscorral/CityTransportGuide.git```
* **Make sure you have Cocoapods installed.**
* Run ```pod install``` on the project directory.
* Open the newly generated **.xcworkspace** file.
* **Enter your API key in the Info.plist**
* Build and run the app

## Tests
- Unit tests for the ViewModel to ensure proper data fetching and filtering.
- Unit tests for the MapElement class to verify the correct creation of MapElements and their properties.
    
    
## Requirements

* Xcode 14.3
* iOS 16.4
* Cocoapods for dependencies

## Dependencies

* Google Maps iOS SDK Library
* Alamofire
* Kingfisher

## Contributing

No contributions will be merged and will be automatically denied as this is a personal project. However, feel free to fork the project making sure to respect the terms detailed in the `LICENSE.md`

## Authors

- Ivan Sanchez

## Contributing

No contributions will be merged and will be automatically denied as this is a personal project. However, feel free to fork the project making sure to respect the terms detailed in the `LICENSE.md`

## Authors

- Ivan Sanchez

## License

This project is licensed under the **MIT License** - see the `LICENSE.md` file for details.

## Reference Links

* [Alamofire Docs](https://alamofire.github.io/Alamofire/)
* [Google Maps SDK for iOS Reference](https://developers.google.com/maps/documentation/ios-sdk/)
* [Installing Maps SDK on IOS](https://developers.google.com/maps/documentation/ios-sdk/config?hl=es-419#use-cocoapods)
