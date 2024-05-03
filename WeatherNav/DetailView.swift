//
//  DetailView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI
import MapKit

struct DetailView: View {
//    let weatherData: ReadyData
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 38.7077507, longitude: -9.1365919),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    )
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            VStack {
                DetailRow()
                    .padding(.top)
                DetailRow()
                VStack {
                    VStack {
                        Map(initialPosition: startPosition) {
                            Marker("Lisboa", coordinate: CLLocationCoordinate2D(latitude: 38.7077507, longitude: -9.1365919))
                        }
                    }
                    .cornerRadius(20)
                    .padding([.leading, .trailing])
                    .frame(width: 400, height: 400)
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct DetailRow: View {
    var body: some View {
        HStack {
            VStack {
                Text("test")
                    .font(.title)
            }
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
            .frame(width: 160, height: 160)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
            )
            VStack {
                Text("test")
            }
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
            .frame(width: 160, height: 160)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
            )
        }
    }
}

#Preview {
//    var data = ReadyData(city: "Lisboa", description: "Sunny", tempHeader: 16)
//    return DetailView(weatherData: data)
    DetailView()
}
