//
//  SelfConfiguringCell.swift
//  ChatApp
//
//  Created by Vasichko Anna on 15.03.2022.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseID: String {get}
    func configure<U: Hashable>(with value: U)
}
