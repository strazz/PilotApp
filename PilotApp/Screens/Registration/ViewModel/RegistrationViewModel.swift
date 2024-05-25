//
//  RegistrationViewModel.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    private let businessLogic: RegistrationBusinessLogic
    @Published var name = ""
    @Published var isNameValid = false
    @Published var password = ""
    @Published var isPasswordValid = false
    @Published var verificationPassword = ""
    @Published var isVerificationPasswordValid = false
    @Published var selectedLicence = ""
    @Published var licenceTypes: [String]
    @Published var isLicenceValid = false
    
    init(businessLogic: RegistrationBusinessLogic) {
        self.businessLogic = businessLogic
        licenceTypes = businessLogic.validLicences
        validateFields()
    }
    
    private func validateFields() {
        validateName()
        validatePassword()
        validateLicence()
        validateConfirmPassword()
    }
    
    private func validateName() {
        $name.map { [unowned self] aName in
            self.businessLogic.isNameValid(name: aName)
        }
        .assign(to: &$isNameValid)
    }
    
    
    private func validatePassword() {
        $password.map { [unowned self] aPassword in
            self.businessLogic.isPasswordValid(username: self.name, password: aPassword)
        }
        .assign(to: &$isPasswordValid)
    }
    
    private func validateLicence() {
        $selectedLicence.map { [unowned self] aLicence in
            self.businessLogic.isLicenceValid(licence: aLicence)
        }
        .assign(to: &$isLicenceValid)
    }
    
    private func validateConfirmPassword() {
        $verificationPassword.map { [unowned self] aPassword in
            aPassword == self.password
        }
        .assign(to: &$isVerificationPasswordValid)
    }
    
    var isRegisterButtonEnabled: Bool {
        isNameValid &&
        isPasswordValid &&
        isVerificationPasswordValid &&
        isLicenceValid
    }
    
    func onRegister() {
        //TODO: save registration data
    }
}
