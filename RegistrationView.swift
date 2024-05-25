//
//  RegistrationView.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            buildNameField()
            buildLicenceField()
            buildPasswordField()
            Spacer()
            buildRegisterButton()
                
        }
        .padding()
        .navigationTitle("Register")
    }
    
    @ViewBuilder func buildNameField() -> some View {
        TextField("Name", text: $viewModel.name)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
        if let error = viewModel.nameError {
            buildErrorView(error: error)
        }
    }
    
    @ViewBuilder func buildLicenceField() -> some View {
        HStack {
            Text("Pilot licence type:")
            Picker("Pilot licence type", selection: $viewModel.selectedLicence) {
                ForEach(viewModel.licenceTypes, id: \.self) { licence in
                    Text(licence)
                }
            }
                   .pickerStyle(.segmented)
        }
        if let error = viewModel.licenceError {
            buildErrorView(error: error)
        }
    }
    
    @ViewBuilder func buildPasswordField() -> some View {
        SecureField("Password", text: $viewModel.password)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
        if let error = viewModel.passwordError {
            buildErrorView(error: error)
        }
        SecureField("Password verification", text: $viewModel.verificationPassword)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
        if let error = viewModel.verificationPasswordError {
            buildErrorView(error: error)
        }
    }
    
    @ViewBuilder func buildRegisterButton() -> some View {
        Button("Register") {
        }
        .buttonStyle(.bordered)
        .disabled(!viewModel.isRegisterButtonEnabled)
    }
    
    @ViewBuilder func buildErrorView(error: Error) -> some View {
        Text(error.localizedDescription)
            .foregroundStyle(.red)
            .fontWeight(.light)
            .font(.caption)
    }
}

#Preview {
    RegistrationView(
        viewModel: RegistrationViewModel(
            businessLogic: RegistrationBusinessLogic()
        )
    )
}
