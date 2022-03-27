//
//  UIScrollView + Extension.swift
//  ChatApp
//
//  Created by Vasichko Anna on 27.03.2022.
//

import UIKit

extension UIScrollView {
    var isAtBottom: Bool {
        contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
