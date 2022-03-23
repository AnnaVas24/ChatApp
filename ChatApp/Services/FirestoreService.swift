//
//  FirestoreService.swift
//  ChatApp
//
//  Created by Vasichko Anna on 18.03.2022.
//

import UIKit
import Firebase
import FirebaseFirestore


class FirestoreService {
    
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func getUserData(user: User, completion: @escaping(Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let mUser = MUser(document: document) else {
                    completion(.failure(UserError.connotUnwrapToMUser))
                    return
                }
                completion(.success(mUser))
            } else {
                completion(.failure(UserError.userInfoNotFound))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, gender: String?, completion: @escaping(Result<MUser, Error>) -> Void) {
        
        guard Validators.isFilled(username: username, description: description, gender: gender) else {
            completion(.failure(UserError.notFilled))
            return
        }
        guard avatarImage != UIImage(named: "avatar") else {
            completion(.failure(UserError.photoNotFound))
            return
        }
        var mUser = MUser(
            username: username!,
            avatarStringURL: "not found",
            id: id,
            email: email,
            description: description!,
            gender: gender!
        )
        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {
            case .success(let url):
                mUser.avatarStringURL = url.absoluteString
                self.usersRef.document(mUser.id).setData(mUser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(mUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
}
