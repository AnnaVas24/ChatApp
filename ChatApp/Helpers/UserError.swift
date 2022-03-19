//
//  UserError.swift
//  ChatApp
//
//  Created by Vasichko Anna on 18.03.2022.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotFound
    case userInfoNotFound
    case connotUnwrapToMUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Please fill out all required fields", comment: "")
        case .photoNotFound:
            return NSLocalizedString("Please add the photo", comment: "")
        case .userInfoNotFound:
            return NSLocalizedString("User does not exist", comment: "")
        case .connotUnwrapToMUser:
            return NSLocalizedString("Cannot unwrap user to type MUser", comment: "")
        }
    }
    
}
