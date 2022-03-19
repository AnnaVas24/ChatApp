//
//  AuthNavigationDelegate.swift
//  ChatApp
//
//  Created by Vasichko Anna on 18.03.2022.
//

import Foundation

protocol AuthNavigationDelegate: AnyObject {
    func toLoginVC()
    func toSignUpVC()
}
