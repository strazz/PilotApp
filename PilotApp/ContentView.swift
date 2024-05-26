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
            case .confirmation(let user):
                PilotAppViewFactory.buildConfirmationView(user: user,
                                                          navigationViewModel: navigationViewModel)
            case .error(let error):
                buildErrorView(error: error)
            case .none:
                EmptyView()
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    PilotAppViewFactory.buildContentView()
}
