//
//  PilotAppViewFactory.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import Foundation
import SwiftUI

class PilotAppViewFactory {
    @MainActor @ViewBuilder static func buildContentView() -> some View {
        let navigationViewModel = NavigationViewModel(persistence: UserDefaultsPersistance(name: nil))
        ContentView(navigationViewModel: navigationViewModel)
    }
    
    @MainActor @ViewBuilder static func buildRegistrationView() -> some View {
        let businessLogic = RegistrationBusinessLogic(repository: LocalLicensesRepository(),
                                                      persistance: UserDefaultsPersistance(name: nil))
        let viewModel = RegistrationViewModel(businessLogic: businessLogic)
        RegistrationView(viewModel: viewModel)
    }
}
