//
//  SignUpViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 12.02.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Glad to see you!", font: .arial26())
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPassLabel = UILabel(text: "Confirm password")
    let alreadyLabel = UILabel(text: "Already have an account?")
    
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonBlack(), isShadow: false)
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .arial20()
        return button
    }()
    
    let emailTF = OneLineTextFild(font: .arial20())
    let passwordTF = OneLineTextFild(font: .arial20())
    let confirmPasswordTF = OneLineTextFild(font: .arial20())
    
    weak var delegate: AuthNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        view.backgroundColor = .mainWhite()
        setupConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }

    @objc private func signUpButtonPressed() {
        AuthService.shared.register(email: emailTF.text, password: passwordTF.text, confirmPassword: confirmPasswordTF.text) { result in
            switch result {
            case .success(let user):
                self.showAlert(title: "Success!", message: "You are registered") {
                    self.present(SetupProfileViewController(currentUser: user), animated: true)
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func loginButtonPressed() {
        dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }
}
// MARK: - Setup Constraits
extension SignUpViewController {
    private func setupConstraints() {
        let emailStackView = UIStackView(arrangeSubviews: [emailLabel,emailTF], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangeSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 0)
        let confirmPassStackView = UIStackView(arrangeSubviews: [confirmPassLabel, confirmPasswordTF], axis: .vertical, spacing: 0)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangeSubviews: [
            emailStackView,
            passwordStackView,
            confirmPassStackView,
            signUpButton
        ],
                                    axis: .vertical,
                                    spacing: 40)
        
        loginButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangeSubviews: [alreadyLabel,loginButton], axis: .horizontal, spacing: 20)
        bottomStackView.alignment = .firstBaseline
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 140),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SignUpViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpViewControllerProvider.ContainerView>) -> SignUpViewController {
           viewController
        }
        
        func updateUIViewController(_ uiViewController: SignUpViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpViewControllerProvider.ContainerView>) {
        }
    }
}


extension UIViewController {
    
    func showAlert(title: String, message: String, completion: @escaping() -> Void = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
