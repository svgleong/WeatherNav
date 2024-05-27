//
//  DetailView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let weatherData: ReadyData
    
    var body: some View {
        ZStack {
            // Set background color
            LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            // Information details
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "thermometer.medium")
                            Text("FEELS LIKE")
                                .font(.headline)
                        }
                        .padding(.bottom, 60)
                        Text(weatherData.feelsLike)
                            .font(.title)
                    }
                    .modifier(LightSquare())
                    VStack {
                        HStack {
                            Image(systemName: "wind")
                            Text("WIND SPEED")
                                .font(.headline)
                        }
                        .padding(.bottom, 60)
                        Text(weatherData.windSpeed)
                            .font(.title)
                    }
                    .modifier(LightSquare())
                }
                .padding(.top)
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "humidity")
                            Text("HUMIDITY")
                                .font(.headline)
                        }
                        .padding(.bottom, 60)
                        Text(weatherData.humidity)
                            .font(.title)
                    }
                    .modifier(LightSquare())
                    VStack {
                        HStack {
                            Image(systemName: "cloud.rain")
                            Text("RAIN")
                                .font(.headline)
                        }
                        .padding(.bottom, 60)
                        Text(weatherData.rainProb)
                            .font(.title)
                    }
                    .modifier(LightSquare())
                }
                
                // Map
                VStack {
                    VStack {
                        let startPosition = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: weatherData.lat, longitude: weatherData.lon),
                                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                            )
                        )
                        
                        Map(initialPosition: startPosition) {
                            Marker(weatherData.city, coordinate: CLLocationCoordinate2D(latitude: weatherData.lat, longitude: weatherData.lon))
                        }
                    }
                    .cornerRadius(20)
                    .padding([.leading, .trailing])
                    .frame(width: 360, height: 350)
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct LightSquare: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
            .frame(width: 160, height: 160)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
            )
    }
}

#Preview {
    let data = ReadyData(city: "Lisboa", description: "Sunny", tempHeader: 16, lat: 38.7077507, lon: -9.1365919, feelsLike: "16ºC", windSpeed: "4.5 m/sec", humidity: "70%", rainProb: "30%", country: "PT", days: [])
    return DetailView(weatherData: data)
}
