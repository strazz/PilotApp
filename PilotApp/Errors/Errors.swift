//
//  Errors.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

enum RegistrationError: LocalizedError {
    case genericError
    
    var errorDescription: String? {
        "An error occurred, please restart the app."
    }
}

enum RepositoryError: LocalizedError {
    case urlNotFound
}

enum ValidationError: LocalizedError {
    case invalidName
    case invalidLicense
    case emptyPassword
    case passwordContainsUsername
    case shortPassword
    case passwordFormat
    case verificationPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidName:
            "Must contain at least one non-whitespace character."
        case .invalidLicense:
            "A valid type of pilot license should be inserted."
        case .emptyPassword:
            "Password cannot be empty."
        case .passwordContainsUsername:
            "Password should not contains username."
        case .shortPassword:
            "Password must be at least 12 characters."
        case .passwordFormat:
            "Password must be a combination of uppercase, lowercase and numbers."
        case .verificationPassword:
            "Must be identical to the password."
        }
    }
}
