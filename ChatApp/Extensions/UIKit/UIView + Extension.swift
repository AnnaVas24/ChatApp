//
//  UIView + Extension.swift
//  ChatApp
//
//  Created by Vasichko Anna on 16.03.2022.
//

import UIKit

extension UIView {
    
    func applyGradient(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        
        let gradientView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1), endColor: #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1))
        
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
    }
}
