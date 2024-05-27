//
//  LoadingView.swift
//  WeatherNav
//
//  Created by SofiaLeong on 27/05/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .controlSize(.large)
    }
}

#Preview {
    LoadingView()
}
