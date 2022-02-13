//
//  SetupProfileViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 13.02.2022.
//

import UIKit

class SetupProfileViewController: UIViewController {

    let imageView = AddPhotoView()
    let welcomeLabel = UILabel(text: "Set up your profile!", font: .arial26())
    let fullNameLabel = UILabel(text: "Full name")
    let aboutMeLabel = UILabel(text: "About me")
    let genderLabel = UILabel(text: "Gender")
    
    let fullNameTF = OneLineTextFild(font: .arial20())
    let aboutMeTF = OneLineTextFild(font: .arial20())
    
    let genderSegmentedControl = UISegmentedControl(first: "Male", second: "Female", third: "Other")
    
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonBlack(), isShadow: false)
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainWhite()
        setupConstraints()
    }

}
// MARK: - Setup Constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        
        let fullNameStackView = UIStackView(arrangeSubviews: [fullNameLabel, fullNameTF], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(arrangeSubviews: [aboutMeLabel, aboutMeTF], axis: .vertical, spacing: 0)
        let genderStackView = UIStackView(arrangeSubviews: [genderLabel, genderSegmentedControl], axis: .vertical, spacing: 10)
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangeSubviews: [
            fullNameStackView,
            aboutMeStackView,
            genderStackView,
            goToChatsButton],
                                    axis: .vertical,
                                    spacing: 40)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(imageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: welcomeLabel.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}
// MARK: - SwiftUI
import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portraitUpsideDown)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = SetupProfileViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) -> SetupProfileViewController {
           viewController
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) {
        }
    }
}
