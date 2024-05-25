//
//  RegistrationBusinessLogic.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

class RegistrationBusinessLogic {
    
    let validLicences = ["PPL", "ATPL", "MPL"]
    private let requiredPasswordLength = 12
    
    func isNameValid(name: String) -> Bool {
        let result = name.wholeMatch(of: /^.*\S.*$/)
        return result != nil
    }
    
    func isLicenceValid(licence: String) -> Bool {
        validLicences.contains(licence)
    }
    
    func isPasswordValid(username: String, password: String) -> Bool {
        password.isEmpty == false &&
        password.contains(username) == false &&
        isPasswordLongEnough(password: password) &&
        isPasswordFormatValid(password: password)
    }
    
    private func isPasswordLongEnough(password: String) -> Bool {
        password.count >= requiredPasswordLength
    }
    
    private func isPasswordFormatValid(password: String) -> Bool {
        let result = password.wholeMatch(of: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/)
        return result != nil
    }
}
