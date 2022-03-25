//
//  ChatRequestViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 16.03.2022.
//

import UIKit
import SDWebImage

class ChatRequestViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: UIImage(named: "human5"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Railey Burges", font: .arial20())
    let messageLabel = UILabel(text: "Hey, whats'up?", font: .systemFont(ofSize: 16))
    let acceptButton = UIButton(title: "ACCEPT", titleColor: .white, backgroundColor: .systemPurple, font: .arial20(), isShadow: false, cornerRadius: 10)
    let denyButton = UIButton(title: "Deny", titleColor: #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1), backgroundColor: .mainWhite(), font: .arial20(), isShadow: false, cornerRadius: 10)
    
    weak var delegate: WaitingChatsNavigation?
    
    private var chat: MChat
    init(chat: MChat){
        self.chat = chat
        nameLabel.text = chat.friendUsername
        messageLabel.text = chat.lastMessageContent
        imageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
        denyButton.addTarget(self, action: #selector(denyButtonPressed), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        acceptButton.applyGradient(cornerRadius: 10)
    }
    
    @objc private func denyButtonPressed(){
        self.dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
    
    @objc private func acceptButtonPressed(){
        self.dismiss(animated: true) {
            self.delegate?.changeToActive(chat: self.chat)
        }
    }

}

extension ChatRequestViewController {
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        
        messageLabel.numberOfLines = 0
        containerView.backgroundColor = .mainWhite()
        containerView.layer.cornerRadius = 30
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        
    
        let buttonStackView = UIStackView(arrangeSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 8)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(buttonStackView)
      
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 36),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 30),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: 30),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            buttonStackView.heightAnchor.constraint(equalToConstant: 54)
        ])
        
    }
}

// MARK: - SwiftUI
import SwiftUI

struct ChatRequestViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = ChatRequestViewController(chat: MChat(friendUsername: "", friendAvatarStringURL: "", lastMessageContent: "", friendId: ""))
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ChatRequestViewControllerProvider.ContainerView>) -> ChatRequestViewController {
           viewController
        }
        
        func updateUIViewController(_ uiViewController: ChatRequestViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ChatRequestViewControllerProvider.ContainerView>) {
        }
    }
}
