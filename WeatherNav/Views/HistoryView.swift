//
//  HistoryView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 13/05/2024.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            // Set background color
            LinearGradient(gradient: Gradient(colors: [.yellow, .teal, .cyan]), startPoint: .top, endPoint: .bottom)
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}
