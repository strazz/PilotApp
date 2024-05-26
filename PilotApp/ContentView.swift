//
//  ContentView.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        NavigationView {
            switch navigationViewModel.currentScreen {
            case .registration:
                PilotAppViewFactory.buildRegistrationView()
            case .confirmation:
                EmptyView()
            case .none:
                EmptyView()
            }
        }
        .environmentObject(navigationViewModel)
    }
}

#Preview {
    PilotAppViewFactory.buildContentView()
}
