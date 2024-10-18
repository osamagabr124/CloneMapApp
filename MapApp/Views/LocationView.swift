//
//  LocationView.swift
//  MapApp
//
//  Created by osama on 23/01/2024.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion,
                annotationItems: vm.locations,
                annotationContent: { location in
                MapMarker(coordinate: location.coordinates, tint: .blue)
//                   // .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
//                    .onTapGesture {
//                        vm.showNextLocation(location: location)
//                    }
            })
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
            
                header
                    .padding()
            
            Spacer()
                ZStack {
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location {
                        LocationPreviewView(location: location)
                                .shadow(color: Color.black.opacity(0.5), radius: 20)
                                .padding()
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                    }
                    
                }
            }
        }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
}

extension LocationsView {
        private var header: some View {
            VStack {
                Button {
                    vm.toggleLocationList()
                } label: {
                    Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: vm.mapLocation)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                }

                
      
            }
                
                if vm.showLocationsList {
                    LocationsListView()
                }
        
     
    }
    .background(.thickMaterial)
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 15)
    }
}

