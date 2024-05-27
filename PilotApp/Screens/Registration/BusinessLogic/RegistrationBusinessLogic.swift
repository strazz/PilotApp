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
    func saveUser(username: String, license: PilotLicense) throws -> User
}

class RegistrationBusinessLogic: RegistrationBusinessLogicProtocol {
    private let repository: LicensesRepository
    var licenses: [PilotLicense] = []
    let persistance: UserPersistance
    let validator: FormValidatorProtocol
    
    init(repository: LicensesRepository,
         persistance: UserPersistance,
         validator: FormValidatorProtocol) {
        self.repository = repository
        self.persistance = persistance
        self.validator = validator
    }
    
    func loadLicenses() async throws {
        licenses = try await repository.getLicenses()
    }
    
    func saveUser(username: String, license: PilotLicense) throws -> User {
        let user = User(name: username, license: license)
        try persistance.saveUser(user: user)
        return user
    }
    
    func validateName(name: String) -> Result<Void, any Error> {
        validator.validateName(name: name)
    }
    
    func validateLicense(license: PilotLicense) -> Result<Void, any Error> {
        validator.validateLicense(license, in: licenses)
    }
    
    func validatePassword(username: String, password: String) -> Result<Void, any Error> {
        validator.validatePassword(username: username, password: password)
    }
}
