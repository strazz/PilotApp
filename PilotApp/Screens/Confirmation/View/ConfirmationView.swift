//
//  ConfirmationView.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import SwiftUI

struct ConfirmationView: View {
    @ObservedObject var viewModel: ConfirmationViewModel
    
    init(viewModel: ConfirmationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            buildLogoutButton()
            
        }
        .navigationTitle("Confirmation")
    }
    
    @ViewBuilder private func buildLogoutButton() -> some View {
        Button("Logout") {
            viewModel.onLogout()
        }
        .buttonStyle(.bordered)
    }
}

#Preview {
    PilotAppViewFactory.buildConfirmationView(navigationViewModel: NavigationViewModel(persistence: UserDefaultsPersistance(name: nil)))
}
