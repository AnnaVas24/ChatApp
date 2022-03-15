//
//  SectionHeader.swift
//  ChatApp
//
//  Created by Vasichko Anna on 15.03.2022.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseID = "SectionHeader"
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    func configure( text: String, font: UIFont, textColor: UIColor) {
        title.text = text
        title.textColor = textColor
        title.font = font
    }
    
    private func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
