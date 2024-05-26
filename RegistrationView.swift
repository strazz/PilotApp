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
            if viewModel.isLoading {
                ProgressView("label.loading".localized)
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
        .navigationTitle("label.register".localized)
        .onAppear() {
            Task { @MainActor in
                await viewModel.loadData()
            }
        }
    }
    
    @ViewBuilder private func buildNameField() -> some View {
        TextField("label.name".localized, text: $viewModel.name)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
        if let error = viewModel.nameError {
            buildErrorView(error: error)
        }
    }
    
    @ViewBuilder private func buildLicenseField() -> some View {
        HStack {
            Text("label.licensetype".localized)
            Picker("label.licensetype".localized, selection: $viewModel.selectedLicense) {
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
    
    @ViewBuilder private func buildPasswordField() -> some View {
        SecureField("label.password".localized, text: $viewModel.password)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .textContentType(.newPassword)
        if let error = viewModel.passwordError {
            buildErrorView(error: error)
        }
        SecureField("label.passwordverification".localized, text: $viewModel.verificationPassword)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .textContentType(.newPassword)
        if let error = viewModel.verificationPasswordError {
            buildErrorView(error: error)
        }
    }
    
    @ViewBuilder private func buildRegisterButton() -> some View {
        Button("label.register".localized) {
            do {
                try viewModel.onRegister()
            } catch {
                print(error)
            }
        }
        .buttonStyle(.bordered)
        .disabled(!viewModel.isRegisterButtonEnabled)
    }
}

#Preview {
    PilotAppViewFactory.buildRegistrationView(navigationViewModel: NavigationViewModel(persistence: UserDefaultsPersistance(name: nil)))
}
