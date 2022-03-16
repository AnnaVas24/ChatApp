//
//  UserCell.swift
//  ChatApp
//
//  Created by Vasichko Anna on 16.03.2022.
//

import UIKit

class UserCell: UICollectionViewCell, SelfConfiguringCell {
   
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "Name Surname", font: .arial20())
    let containerView = UIView()
 
    
    static var reuseID = "UserCell"
    
    func configure<U>(with value: U) where U : Hashable {
        guard let user:MUser = value as? MUser else {return}
        friendImageView.image = UIImage(named: user.avatarStringURL)
        friendName.text = user.username
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.layer.shadowColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 4
        self.containerView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Constraints
extension UserCell {
    private func setupConstraints(){
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(friendImageView)
        containerView.addSubview(friendName)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            friendImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: friendImageView.bottomAnchor),
            friendName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            friendName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            friendName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
