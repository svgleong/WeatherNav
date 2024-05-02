//
//  ContentView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.teal, .cyan, .yellow]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Search Bar
                    TextField("Search", text: $searchText)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(30)
                    
                    // Clickable to show more info about the city
                    Button(action: {}, label: {
                        VStack {
                            Text("Lisbon")
                                .font(.system(size: 40))
                            Text("16ºC")
                        }
                        .padding([.top, .bottom], 10)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                        )
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    // Weather every 3 hours
                    dayForecast()
                    
                }
                .padding([.leading, .trailing], 20)
            }
            .navigationTitle("WeatherNav")
        }
    }
}

struct dayForecast: View {
    
    var body: some View {
        Section {
            VStack {
                Text("Today")
                    .padding(.top)
                List() {
                    ForEach(1..<20) { i in
                        // cell
                        HStack {
                            Text("\(i)")
                            Image(systemName: "sun.max")
                            Text("Temp")
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                // will need GeometryReader
                .frame(height: 470)
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
    }
}

#Preview {
    ContentView()
}
