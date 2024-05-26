//
//  ConfirmationViewModel.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import Foundation
import SwiftUI

class ConfirmationViewModel: ObservableObject {
    weak var navigationViewModel: NavigationViewModel?
    private let persistance: UserPersistance
    
    init(persistance: UserPersistance) {
        self.persistance = persistance
    }
    
    func onLogout() {
        persistance.deleteUser()
        navigationViewModel?.currentScreen = .registration
    }
}
