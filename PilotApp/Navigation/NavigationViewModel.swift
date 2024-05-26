//
//  NavigationViewModel.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import Foundation

enum Screen {
    case registration
    case confirmation
}

class NavigationViewModel: ObservableObject {
    @Published var currentScreen: Screen?
    private let persistence: UserPersistance
    
    init(persistence: UserPersistance) {
        self.currentScreen = try? persistence.getUser() == nil ? .registration : .confirmation
        self.persistence = persistence
    }
}
