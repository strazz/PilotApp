//
//  RegistrationBusinessLogic.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidName
    case invalidLicence
    case emptyPassword
    case passwordContainsUsername
    case shortPassword
    case passwordFormat
    case verificationPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidName:
            "Must contain at least one non-whitespace character."
        case .invalidLicence:
            "A valid type of pilot license should be inserted."
        case .emptyPassword:
            "Password cannot be empty."
        case .passwordContainsUsername:
            "Password should not contains username."
        case .shortPassword:
            "Password must be at least 12 characters."
        case .passwordFormat:
            "Password must be a combination of uppercase, lowercase and numbers."
        case .verificationPassword:
            "Must be identical to the password."
        }
    }
}

class RegistrationBusinessLogic {
    
    let validLicences = ["PPL", "ATPL", "MPL"]
    private let requiredPasswordLength = 12
    
    func validateName(name: String) -> Result<Void, Error> {
        let result = name.wholeMatch(of: /^.*\S.*$/)
        if result != nil {
            return .success(())
        }
        return .failure(ValidationError.invalidName)
    }
    
    func validateLicence(licence: String) -> Result<Void, Error> {
        if validLicences.contains(licence) {
            return .success(())
        }
        return .failure(ValidationError.invalidLicence)
    }
    
    func validatePassword(username: String, password: String) -> Result<Void, Error> {
        if password.isEmpty {
            return .failure(ValidationError.emptyPassword)
        }
        if password.contains(username) {
            return .failure(ValidationError.passwordContainsUsername)
        }
        if !isPasswordLongEnough(password: password) {
            return .failure(ValidationError.shortPassword)
        }
        if !isPasswordFormatValid(password: password) {
            return .failure(ValidationError.passwordFormat)
        }
        return .success(())
    }
    
    private func isPasswordLongEnough(password: String) -> Bool {
        password.count >= requiredPasswordLength
    }
    
    private func isPasswordFormatValid(password: String) -> Bool {
        let result = password.wholeMatch(of: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/)
        return result != nil
    }
}
