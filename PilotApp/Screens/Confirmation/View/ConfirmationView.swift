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
        VStack(spacing: 16) {
            buildWelcomeView()
            Spacer()
            buildLogoutButton()
            
        }
        .padding()
        .navigationTitle("label.confirmation".localized)
    }
    
    @ViewBuilder private func buildLogoutButton() -> some View {
        VStack(alignment: .center) {
            Button("label.logout".localized) {
                viewModel.onLogout()
            }
            .buttonStyle(.bordered)
        }
    }
    
    @ViewBuilder private func buildWelcomeView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(String(format: "label.format.userregistered".localized, viewModel.username))
            Text(String(format: "label.format.welcome".localized, viewModel.username))
            Text(String(format: "label.format.license".localized, viewModel.license))
            Text(String(format: "label.allowedaircrafts".localized, viewModel.allowedAircrafts))
            List(viewModel.allowedAircrafts, id: \.self) { item in
                Text(item)
            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    let user = User(name: "test", license: PilotLicense(type: .atpl, aircrafts: ["test", "test2"]))
    return PilotAppViewFactory.buildConfirmationView(user: user, navigationViewModel: NavigationViewModel(persistence: UserDefaultsPersistance(name: nil)))
}
