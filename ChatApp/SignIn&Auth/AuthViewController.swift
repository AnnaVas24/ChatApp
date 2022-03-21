//
//  ViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 11.02.2022.
//

import UIKit
import GoogleSignIn

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: UIImage(named: "logo"), contentMode: .scaleAspectFit)
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Sign up with")
    let alreadyLabel = UILabel(text: "Already have an account?")

  
    
    let googleB = GIDSignInButton()
    
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonBlack(), isShadow: false)
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainWhite()
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        signUpVC.delegate = self
        loginVC.delegate = self
        
        googleB.addTarget(self, action: #selector(googlePressed), for: .touchUpInside)
    }
   
    @objc private func emailButtonPressed() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonPressed() {
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func googlePressed() {
        sign()
    }
    
}

// MARK: - Setup constraints
extension AuthViewController {
    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyLabel, button: loginButton)
        
        googleB.style = .wide
        let googleButtonView = ButtonFormView(label: googleLabel, button: googleB)
    
        let stackView = UIStackView(arrangeSubviews: [googleButtonView, emailView, loginView], axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension AuthViewController: AuthNavigationDelegate {
    func toLoginVC() {
        present(loginVC, animated: true)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true)
    }
}

extension AuthViewController {
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

struct AuthViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthViewControllerProvider.ContainerView>) -> AuthViewController {
           viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthViewControllerProvider.ContainerView>) {
        }
    }
}
