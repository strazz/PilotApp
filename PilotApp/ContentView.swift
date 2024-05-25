//
//  ContentView.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RegistrationView(
            viewModel: RegistrationViewModel(
                businessLogic: RegistrationBusinessLogic(repository: LocalLicensesRepository(), 
                                                         persistance: UserDefaultsPersistance(name: nil))
            )
        )
    }
}

#Preview {
    ContentView()
}
