//
//  CityDetailView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 14/05/2024.
//

import SwiftUI
import MapKit

struct CityDetailView: View {
    
    let city: CityInfo
    
    var body: some View {
        ZStack {
            // Set background color
            LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Map
                VStack {
                    VStack {
                        let startPosition = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon),
                                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                            )
                        )
                        
                        Map(initialPosition: startPosition) {
                            Marker(city.name, coordinate: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon))
                        }
                    }
                    .cornerRadius(20)
                    .frame(width: 360, height: 350)
                }
                
                Section {
                    VStack {
                        Text("\(city.name), \(city.country)\n")
                            .font(.system(size: 22))
                        Text("lat: \(city.lat)")
                        Text("lon: \(city.lon)")
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                }
                
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom])
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                )
            }
            .padding()
            .foregroundColor(.white)
            .bold()
        }
    }
}

#Preview {
    CityDetailView(city: CityInfo(name: "Lisbon", country: "PT", lat: 38.7167, lon: -9.1333))
}
