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
                PilotAppViewFactory.buildRegistrationView(navigationViewModel: navigationViewModel)
            case .confirmation:
                PilotAppViewFactory.buildConfirmationView(navigationViewModel: navigationViewModel)
            case .none:
                EmptyView()
            }
        }
    }
}

#Preview {
    PilotAppViewFactory.buildContentView()
}
