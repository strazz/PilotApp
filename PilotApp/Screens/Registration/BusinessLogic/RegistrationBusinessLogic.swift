//
//  RegistrationBusinessLogic.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

protocol RegistrationBusinessLogicProtocol {
    var licenses: [LicenseType] { get }
    func loadLicenses() async throws
    func validateName(name: String) -> Result<Void, Error>
    func validateLicense(license: String) -> Result<Void, Error>
    func validatePassword(username: String, password: String) -> Result<Void, Error>
}

class RegistrationBusinessLogic: RegistrationBusinessLogicProtocol {
    
    private let repository: LicensesRepository
    private let requiredPasswordLength = 12
    var licenses: [LicenseType] = []
    
    init(repository: LicensesRepository) {
        self.repository = repository
    }
    
    func loadLicenses() async throws {
        licenses = try await repository.getLicenses().compactMap({ license in
            license.type
        })
    }
    
    func validateName(name: String) -> Result<Void, Error> {
        let result = name.wholeMatch(of: /^.*\S.*$/)
        if result != nil {
            return .success(())
        }
        return .failure(ValidationError.invalidName)
    }
    
    func validateLicense(license: String) -> Result<Void, Error> {
        if licenses.compactMap({ $0.rawValue }).contains(license) {
            return .success(())
        }
        return .failure(ValidationError.invalidLicense)
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
