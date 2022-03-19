//
//  Validators.swift
//  ChatApp
//
//  Created by Vasichko Anna on 18.03.2022.
//

import Foundation

class Validators {
    
    static func isFilled(email: String?, password: String?, confirmedPassword: String?) -> Bool {
        guard let password = password,
        let email = email,
              let confirmedPassword = confirmedPassword,
              password != "",
              email != "",
              confirmedPassword != "" else { return false}
return true
    }
    
    static func isFilled(username: String?, description: String?, gender: String?) -> Bool {
        guard let description = description,
        let username = username,
              let gender = gender,
              description != "",
              username != "",
              gender != "" else { return false}
return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
