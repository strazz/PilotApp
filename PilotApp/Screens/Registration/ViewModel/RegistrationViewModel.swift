//
//  RegistrationViewModel.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation
import Combine

@MainActor class RegistrationViewModel: ObservableObject {
    private let businessLogic: RegistrationBusinessLogicProtocol
    @Published var name = ""
    @Published var nameError: Error?
    @Published var password = ""
    @Published var passwordError: Error?
    @Published var verificationPassword = ""
    @Published var verificationPasswordError: Error?
    @Published var selectedLicense: PilotLicense?
    @Published var licenses: [PilotLicense] = []
    @Published var licenseError: Error?
    @Published var applicationError: Error?
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(businessLogic: RegistrationBusinessLogicProtocol) {
        self.businessLogic = businessLogic
        validateFields()
    }
    
    func loadData() async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            try await businessLogic.loadLicenses()
            licenses = businessLogic.licenses
        } catch {
            applicationError =  ApplicationError.genericError
        }
    }
    
    deinit {
        cancellables.forEach({ $0.cancel() })
    }
    
    private func validateFields() {
        validateName()
        validatePassword()
        validateLicense()
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
    
    private func validateLicense() {
        $selectedLicense.map { [unowned self] aLicense in
            if let aLicense {
                return self.businessLogic.validateLicense(license: aLicense)
            }
            return .failure(ValidationError.invalidLicense)
        }
        .sink(receiveValue: { result in
            switch result {
            case .failure(let error):
                self.licenseError = error
            case .success:
                self.licenseError = nil
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
        licenseError == nil
    }
    
    func onRegister() {
        guard let selectedLicense else {
            applicationError = ValidationError.invalidLicense
            return
        }
        do {
            try businessLogic.saveUser(username: name, license: selectedLicense)
        } catch {
            applicationError = error
        }
    }
}
