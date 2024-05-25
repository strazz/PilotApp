//
//  RegistrationViewModel.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    private let businessLogic: RegistrationBusinessLogic
    @Published var name = ""
    @Published var nameError: Error?
    @Published var password = ""
    @Published var passwordError: Error?
    @Published var verificationPassword = ""
    @Published var verificationPasswordError: Error?
    @Published var selectedLicence = ""
    @Published var licenceTypes: [String]
    @Published var licenceError: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(businessLogic: RegistrationBusinessLogic) {
        self.businessLogic = businessLogic
        licenceTypes = businessLogic.validLicences
        validateFields()
    }
    
    deinit {
        cancellables.forEach({ $0.cancel() })
    }
    
    private func validateFields() {
        validateName()
        validatePassword()
        validateLicence()
        validateConfirmPassword()
    }
    
    private func validateName() {
        $name.map { [unowned self] aName in
            self.businessLogic.validateName(name: aName)
        }
        .sink(receiveValue: { result in
            switch result {
            case .failure(let error):
                self.nameError = error
            case .success:
                self.nameError = nil
            }
        })
        .store(in: &cancellables)
    }
    
    
    private func validatePassword() {
        $password.map { [unowned self] aPassword in
            if aPassword == self.verificationPassword {
                self.verificationPasswordError = nil
            } else {
                self.verificationPasswordError = ValidationError.verificationPassword
            }
            return self.businessLogic.validatePassword(username: self.name, password: aPassword)
        }
        .sink(receiveValue: { result in
            switch result {
            case .failure(let error):
                self.passwordError = error
            case .success:
                self.passwordError = nil
            }
        })
        .store(in: &cancellables)
    }
    
    private func validateLicence() {
        $selectedLicence.map { [unowned self] aLicence in
            self.businessLogic.validateLicence(licence: aLicence)
        }
        .sink(receiveValue: { result in
            switch result {
            case .failure(let error):
                self.licenceError = error
            case .success:
                self.licenceError = nil
            }
        })
        .store(in: &cancellables)
    }
    
    private func validateConfirmPassword() {
        $verificationPassword.map { [unowned self] aPassword -> Result<Void, Error> in
            if aPassword == self.password {
                return Result.success(())
            }
            return Result.failure(ValidationError.verificationPassword)
        }
        .sink { result in
            switch result {
            case .failure(let error):
                self.verificationPasswordError = error
            case .success:
                self.verificationPasswordError = nil
            }
        }
        .store(in: &cancellables)
    }
    
    var isRegisterButtonEnabled: Bool {
        nameError == nil &&
        passwordError == nil &&
        verificationPasswordError == nil &&
        licenceError == nil
    }
    
    func onRegister() {
        //TODO: save registration data
    }
}
