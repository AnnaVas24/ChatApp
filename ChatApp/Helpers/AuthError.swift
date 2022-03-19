//
//  AuthError.swift
//  ChatApp
//
//  Created by Vasichko Anna on 18.03.2022.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Please fill out all required fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Please use the correct email", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("The passwords do not match", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error occured", comment: "")
        case .serverError:
            return NSLocalizedString("Server error occured", comment: "")
        }
    }
}
