//
//  WaitingChatCell.swift
//  ChatApp
//
//  Created by Vasichko Anna on 15.03.2022.
//

import UIKit
import SDWebImage

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    
    
    
    static var reuseID = "WaitingChatCell"
    
    let friendImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setupConstraints()
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else {return}
        friendImage.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
    }
    
    private func setupConstraints() {
        friendImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImage)
        
        NSLayoutConstraint.activate([
            friendImage.topAnchor.constraint(equalTo: self.topAnchor),
            friendImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            friendImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
