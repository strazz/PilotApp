//
//  NavigationViewModel.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import Foundation

enum Screen {
    case registration
    case confirmation(user: User)
    case error(error: Error)
}

class NavigationViewModel: ObservableObject {
    @Published var currentScreen: Screen?
    private let persistence: UserPersistance
    
    init(persistence: UserPersistance) {
        self.persistence = persistence
        setInitialState()
    }
    
    private func setInitialState() {
        do {
            let user = try persistence.getUser()
            currentScreen = .confirmation(user: user)
        } catch {
            switch error {
            case ApplicationError.userNotFoundError:
                currentScreen = .registration
            default:
                currentScreen = .error(error: error)
            }
        }
    }
}
