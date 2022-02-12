//
//  StackView + Extension.swift
//  ChatApp
//
//  Created by Vasichko Anna on 12.02.2022.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangeSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangeSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
