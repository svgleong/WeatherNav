//
//  ContentView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 02/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var showingSheet = false
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                    .opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                if viewModel.weatherData != nil {
                    VStack {
                        // Search Bar
                        TextField("Search", text: $searchText)
                            .padding(10)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(30)
                        
                        // Clickable to show more info about the city
                        Button(action: {
                            showingSheet.toggle()
                        }, label: {
                            VStack {
                                Text(viewModel.city)
                                    .font(.system(size: 40))
                                Text(viewModel.description)
                                    .font(.title3)
                                Text(viewModel.temperature)
                            }
                            .padding([.top, .bottom], 10)
                            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                            
                        })
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showingSheet, content: {
                            DetailView()
                        })
                        
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<5, id: \.self) { i in
                                DayForecast(data: viewModel.weatherData!, i: i, date: viewModel.getDate(i))
                            }
                        }
                    }
                    .padding([.leading, .trailing], 10)
                }
            }
//            .fontDesign(.default)
            .foregroundColor(.white)
            .bold()
            .task {
                await viewModel.fetchWeatherData()
            }
        }
    }
}

struct DayForecast: View {
    let data: ReadyData
    let i: Int
    let date: String
    
    var body: some View {
        Section {
            VStack {
                Text(date)
                    .padding(.bottom)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(data.days[i].hours, id: \.dt_txt) { list in
                            VStack(spacing: 5) {
                                Text(data.getHour(list))
                                Image(systemName: data.getIcon(list))
                                    .symbolRenderingMode(.multicolor)
                                    .frame(height: 30)
                                Text(data.getTemperature(list))
                            }
                            .frame(width: 60)
                        }
                    }
                    .padding([.leading, .trailing], 10)
                }
            }
            .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
        }
        .padding([.top, .bottom])
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
        )
    }
}

#Preview {
    ContentView()
}

// http://api.openweathermap.org/geo/1.0/direct?q=lisbon&&appid=7387b76e9dd3fb79c023720b2c4fe133

//api.openweathermap.org/data/2.5/forecast?lat=38.7077507&lon=-9.1365919&appid=7387b76e9dd3fb79c023720b2c4fe133
