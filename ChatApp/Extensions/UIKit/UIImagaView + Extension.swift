//
//  UIImagaView + Extension.swift
//  ChatApp
//
//  Created by Vasichko Anna on 12.02.2022.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}
