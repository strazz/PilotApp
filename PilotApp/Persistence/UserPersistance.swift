//
//  UserPersistance.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import Foundation

protocol UserPersistance {
    func saveUser(user: User) throws
    func getUser() throws -> User?
    func deleteUser()
}
