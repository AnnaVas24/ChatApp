//
//  UILabel + Extension.swift
//  ChatApp
//
//  Created by Vasichko Anna on 12.02.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .arial20()) {
        self.init()
        self.text = text
        self.font = font
    }
    
}
