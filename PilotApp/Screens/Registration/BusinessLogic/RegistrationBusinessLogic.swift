//
//  RegistrationBusinessLogic.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

protocol RegistrationBusinessLogicProtocol {
    var licenses: [PilotLicense] { get }
    func loadLicenses() async throws
    func validateName(name: String) -> Result<Void, Error>
    func validateLicense(license: PilotLicense) -> Result<Void, Error>
    func validatePassword(username: String, password: String) -> Result<Void, Error>
    func saveUser(username: String, license: PilotLicense) throws
}

class RegistrationBusinessLogic: RegistrationBusinessLogicProtocol {
    
    private let repository: LicensesRepository
    private let requiredPasswordLength = 12
    var licenses: [PilotLicense] = []
    let persistance: UserPersistance
    
    init(repository: LicensesRepository,
         persistance: UserPersistance) {
        self.repository = repository
        self.persistance = persistance
    }
    
    func loadLicenses() async throws {
        licenses = try await repository.getLicenses()
    }
    
    func validateName(name: String) -> Result<Void, Error> {
        let result = name.wholeMatch(of: /^.*\S.*$/)
        if result != nil {
            return .success(())
        }
        return .failure(ValidationError.invalidName)
    }
    
    func validateLicense(license: PilotLicense) -> Result<Void, Error> {
        if licenses.contains(license) {
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
    
    func saveUser(username: String, license: PilotLicense) throws {
        let user = User(name: username, license: license)
        try persistance.saveUser(user: user)
    }
}
