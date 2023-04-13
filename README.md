# City Transport Guide

City Transport Guide is an iOS application that helps users explore the public transportation options in the city of Lisbon, Portugal. The app displays a map with markers for different public transport resources like buses, trains, and scooters, and provides additional information about each resource when a user taps on a marker.

## Features

- Displays a map with public transport resources in Lisbon
- Fetches real-time data from the API for the resources
- Provides detailed information about each resource, including:
  - Name
  - Coordinates
  - Type of transport
  - Available resources
  - Other relevant parameters
- Customizable InfoView with bold keys and standard values
- Allows users to open the resource location in Google Maps
- Handles API error responses and displays alerts to the user
- Uses the MVVM architectural pattern

## Getting Started

These instructions will help you set up the project on your local machine for development and testing purposes.

    
## Screenshots

<img src="https://user-images.githubusercontent.com/17148950/231614044-67fc83e2-1ca7-44bb-b394-668af564188c.png" alt="Launch screen:
" width="317" height="688" ></img>            <img src="https://user-images.githubusercontent.com/17148950/231613998-03a737fe-9a45-420d-9af2-b1c6b59f2610.png" alt="Error handling: 
" width="317" height="688" ></img>


## How to install  🚧 WIP 🚧

* Clone the repository
* Make sure you have cocoapods installed.
* Run pod install on the project directory.
* Open the newly generated .xcworkspace file.
* Enter your API key in the Info.plist
* Build and rund the app
    
## Requirements

* Xcode 14.3
* iOS 16.0 or higher
* Cocoapods for dependencies

## Dependencies

* Google Maps iOS SDK Library
* Alamofire
* Kingfisher

## Authors

- Ivan Sanchez

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.

## Reference Links

* [Alamofire Docs](https://alamofire.github.io/Alamofire/)
* [Google Maps SDK for iOS Reference](https://developers.google.com/maps/documentation/ios-sdk/)
* [Installing Maps SDK on IOS](https://developers.google.com/maps/documentation/ios-sdk/config?hl=es-419#use-cocoapods)
