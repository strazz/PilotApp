//
//  Errors.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

enum ApplicationError: LocalizedError {
    case genericError
    case userNotFoundError
    
    var errorDescription: String? {
        switch self {
        case .genericError:
            "error.generic".localized
        case .userNotFoundError:
            "error.usernotfound".localized
        }
    }
}

enum RepositoryError: LocalizedError {
    case urlNotFound
    
    var errorDescription: String? {
        "error.urlnotfound".localized
    }
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
            "error.username".localized
        case .invalidLicense:
            "error.license".localized
        case .emptyPassword:
            "error.emptypassword".localized
        case .passwordContainsUsername:
            "error.userpassword".localized
        case .shortPassword:
            "error.shortpassword".localized
        case .passwordFormat:
            "error.formatpassword".localized
        case .verificationPassword:
            "error.verificationpassword".localized
        }
    }
}
