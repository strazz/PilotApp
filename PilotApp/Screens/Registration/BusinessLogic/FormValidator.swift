//
//  FormValidator.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 28/05/24.
//

import Foundation

protocol FormValidatorProtocol {
    func validateName(name: String) -> Result<Void, Error>
    func validateLicense(_ license: PilotLicense, in licenses: [PilotLicense]) -> Result<Void, Error>
    func validatePassword(username: String, password: String) -> Result<Void, Error>
}

class FormValidator: FormValidatorProtocol {
    
    private let requiredPasswordLength = 12
    
    func validateName(name: String) -> Result<Void, Error> {
        let result = name.wholeMatch(of: /^.*\S.*$/)
        if result != nil {
            return .success(())
        }
        return .failure(ValidationError.invalidName)
    }
    
    func validateLicense(_ license: PilotLicense, in licenses: [PilotLicense]) -> Result<Void, Error> {
        if licenses.contains(license) {
            return .success(())
        }
        return .failure(ValidationError.invalidLicense)
    }
    
    func validatePassword(username: String, password: String) -> Result<Void, Error> {
        if password.isEmpty {
            return .failure(ValidationError.emptyPassword)
        }
        if password.lowercased().contains(username.lowercased()) {
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
