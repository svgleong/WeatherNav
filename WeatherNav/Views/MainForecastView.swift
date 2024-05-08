//
//  MainForecastView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 07/05/2024.
//

import SwiftUI

struct MainForecastView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            // Search Bar
            TextField("Search", text: $viewModel.searchText)
                .foregroundColor(.gray)
                .padding(10)
                .background(Color.white.opacity(0.8))
                .cornerRadius(30)
                .onSubmit {
                    Task {
                        await viewModel.loadData()
                    }
                }
            
            // Clickable to show more info about the city
            Button(action: {
                viewModel.showingSheet.toggle()
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
            .sheet(isPresented: $viewModel.showingSheet, content: {
                DetailView(weatherData: viewModel.weatherData!)
            })
            
            // Section for each day
            ScrollView(showsIndicators: false) {
                ForEach(0..<5, id: \.self) { i in
                    DayForecast(data: viewModel.weatherData!, i: i, date: viewModel.getDate(i))
                }
            }
        }
        .padding([.leading, .trailing], 10)
        .alert(isPresented: $viewModel.hasFailed) {
            Alert(title: Text("Error"), message: Text("An error occured fetching the weather for that city! Please try again"), dismissButton: .default(Text("Got it!")))
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

//#Preview {
//    MainForecastView()
//}
