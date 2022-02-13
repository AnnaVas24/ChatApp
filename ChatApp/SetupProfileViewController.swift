//
//  SetupProfileViewController.swift
//  ChatApp
//
//  Created by Vasichko Anna on 13.02.2022.
//

import UIKit

class SetupProfileViewController: UIViewController {

    let imageView = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .mainWhite()
        setupConstraints()
    }

}
// MARK: - Setup Constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
