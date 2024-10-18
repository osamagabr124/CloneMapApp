//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by osama on 24/01/2024.
//

import Foundation
import MapKit
import SwiftUI
class LocationsViewModel: ObservableObject {
    
    // All locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // show locations list
    @Published var showLocationsList: Bool = false
    
    init () {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion (location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion( center: location.coordinates, span: mapSpan)
        }
    }

     func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
            //showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        
        // current index
        
       /*
        let currentIndex = locations.firstIndex { location in
            return location == mapLocation
        }
        */
        
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            return
        }
        
        //check if the next index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // if next index is not valid let it = the first index
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // if next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
}
