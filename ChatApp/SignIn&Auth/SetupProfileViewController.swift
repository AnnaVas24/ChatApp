//
//  SetupProfileViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 13.02.2022.
//

import UIKit
import FirebaseAuth
import SDWebImage

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
    
    private let currentUser: User
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            fullNameTF.text = username
        }
        
        if let photoURL = currentUser.photoURL {
            imageView.circleImageView.sd_setImage(with: photoURL, completed: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        view.backgroundColor = .mainWhite()
        setupConstraints()
        goToChatsButton.addTarget(self, action: #selector(goToChats), for: .touchUpInside)
        
        imageView.plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
    }
    
    @objc private func plusButtonPressed(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @objc private func goToChats() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid, email: currentUser.email!, username: fullNameTF.text, avatarImage: imageView.circleImageView.image, description: aboutMeTF.text, gender: genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            case .success(let mUser):
                self.showAlert(title: "Success!", message: "Wish you good comunication!") {
                    let mainTabBar = MainTabBarController(currentUser: mUser)
                    mainTabBar.modalPresentationStyle = .fullScreen
                    self.present(mainTabBar, animated: true)
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        imageView.circleImageView.image = image
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
        let viewController = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) -> SetupProfileViewController {
           viewController
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileViewControllerProvider.ContainerView>) {
        }
    }
}
