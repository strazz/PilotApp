//
//  RegistrationView.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @ObservedObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                buildNameField()
                buildLicenseField()
                buildPasswordField()
                Spacer()
                buildRegisterButton()
                if let error = viewModel.applicationError {
                    buildErrorView(error: error)
                }
            }       
        }
        .padding()
        .navigationTitle("Register")
        .onAppear() {
            Task { @MainActor in
                await viewModel.loadData()
            }
        }
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
    
    @ViewBuilder func buildLicenseField() -> some View {
        HStack {
            Text("Pilot license type:")
            Picker("Pilot license type", selection: $viewModel.selectedLicense) {
                ForEach(viewModel.licenses, id: \.self) { license in
                    Text(license.type.rawValue.uppercased()).tag(Optional(license))
                }
            }
                   .pickerStyle(.segmented)
        }
        if let error = viewModel.licenseError {
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
            viewModel.onRegister()
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
    PilotAppViewFactory.buildRegistrationView()
}
