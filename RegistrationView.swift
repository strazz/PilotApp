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
        if !viewModel.isNameValid {
            Text("Must contain at least one non-whitespace character.")
                .foregroundStyle(.red)
                .fontWeight(.light)
                .font(.caption)
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
        if !viewModel.isLicenceValid {
            Text("A valid type of pilot license should be inserted.")
                .foregroundStyle(.red)
                .fontWeight(.light)
                .font(.caption)
        }
    }
    
    @ViewBuilder func buildPasswordField() -> some View {
        SecureField("Password", text: $viewModel.password)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
        if !viewModel.isPasswordValid {
            Text("Must be at least 12 characters, a combination of uppercase, lowercase and numbers and it’s not allowed to have the username in there.")
                .foregroundStyle(.red)
                .fontWeight(.light)
                .font(.caption)
        }
        SecureField("Password verification", text: $viewModel.verificationPassword)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
        if !viewModel.isVerificationPasswordValid {
            Text("Must be identical to the password.")
                .foregroundStyle(.red)
                .fontWeight(.light)
                .font(.caption)
        }
    }
    
    @ViewBuilder func buildRegisterButton() -> some View {
        Button("Register") {
        }
        .buttonStyle(.bordered)
        .disabled(!viewModel.isRegisterButtonEnabled)
    }
}

#Preview {
    RegistrationView(
        viewModel: RegistrationViewModel(
            businessLogic: RegistrationBusinessLogic()
        )
    )
}
