//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 13.02.2022.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    let welcomeLabel = UILabel(text: "Welcome back!", font: .arial26())
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "Or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needLabel = UILabel(text: "Need an account?")
    
    let googleB = GIDSignInButton()
    
    let emailTF = OneLineTextFild(font: .arial20())
    let passwordTF = OneLineTextFild(font: .arial20())
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonBlack(), isShadow: false)
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .arial20()
        return button
    }()
    
    weak var delegate: AuthNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainWhite()
        setupConstrains()
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
    
        googleB.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
    }
    
    @objc private func loginButtonPressed() {
        AuthService.shared.login(email: emailTF.text, password: passwordTF.text) { result in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                    case .success(let mUser):
                        let mainTabBar = MainTabBarController(currentUser: mUser)
                        mainTabBar.modalPresentationStyle = .fullScreen
                        self.present(mainTabBar, animated: true)
                    case .failure(_):
                        self.present(SetupProfileViewController(currentUser: user), animated: true)
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
        
    }
    
    @objc private func signUpButtonPressed() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
    
    @objc private func googleButtonPressed() {
        sign()
    }
}
// MARK: - Setup Constraits
extension LoginViewController {
    private func setupConstrains(){
        
        googleB.style = .wide
        
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleB)
        let emailStackView = UIStackView(arrangeSubviews: [emailLabel,emailTF], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangeSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 0)
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangeSubviews: [
            loginWithView,
            orLabel,
            emailStackView,
            passwordStackView,
            loginButton
        ],
                                    axis: .vertical,
                                    spacing: 40)
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangeSubviews: [needLabel, signUpButton], axis: .horizontal, spacing: 20)
        bottomStackView.alignment = .firstBaseline
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
}

extension LoginViewController {
    func sign() {
        AuthService.shared.loginGoogle(viewController: self) { result in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                    case .success(let muser):
                        self.showAlert(title: "Success!", message: "You are registered") {
                            let mainTabBar = MainTabBarController(currentUser: muser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            self.present(mainTabBar, animated: true)
                        }
                    case .failure(_):
                        self.showAlert(title: "Success!", message: "You are registered") {
                            self.present(SetupProfileViewController(currentUser: user), animated: true)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

// MARK: - SwiftUI
import SwiftUI

struct LoginViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = LoginViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginViewControllerProvider.ContainerView>) -> LoginViewController {
           viewController
        }
        
        func updateUIViewController(_ uiViewController: LoginViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginViewControllerProvider.ContainerView>) {
        }
    }
}
