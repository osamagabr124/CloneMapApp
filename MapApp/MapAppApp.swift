//
//  MapAppApp.swift
//  MapApp
//
//  Created by osama on 23/01/2024.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
               
        }
    }
}
