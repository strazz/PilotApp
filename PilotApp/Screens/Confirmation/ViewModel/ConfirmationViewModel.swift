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
    private let user: User
    private let persistance: UserPersistance
    @Published var username: String
    @Published var allowedAircrafts: [String] = []
    @Published var license: String
    
    init(user: User, persistance: UserPersistance) {
        self.user = user
        self.persistance = persistance
        username = user.name
        allowedAircrafts = user.license.aircrafts
        license = user.license.type.rawValue.uppercased()
    }
    
    func onLogout() {
        persistance.deleteUser()
        navigationViewModel?.currentScreen = .registration
    }
}
