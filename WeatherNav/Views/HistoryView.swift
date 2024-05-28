//
//  HistoryView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject private var viewModel = HistoryViewModel()
    @FetchRequest(sortDescriptors: []) var history: FetchedResults<CityEntity>
    
    var body: some View {
        ZStack {
            // Set background color
            LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                List(viewModel.cities, id: \.self) { city in
                    NavigationLink("\(city.name)", destination: CityDetailView(city: city))
                        .listRowBackground(Color.white.opacity(0.2))
                        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .foregroundColor(.white)
        .font(.system(size: 20))
        .bold()
        .onAppear() {
            viewModel.loadData(history)
        }
    }
}

#Preview {
    HistoryView()
}
