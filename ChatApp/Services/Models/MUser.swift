//
//  MUser.swift
//  ChatApp
//
//  Created by Vasichko Anna on 16.03.2022.
//

import UIKit
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: String
    var email: String
    var descrtiption: String
    var gender: String
    
    init(username: String, avatarStringURL: String, id: String, email: String, description: String, gender: String) {
        self.username = username
        self.avatarStringURL = avatarStringURL
        self.id = id
        self.email = email
        self.descrtiption = description
        self.gender = gender
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else {return nil}
        guard let username = data["username"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let id = data["uid"] as? String,
        let email = data["email"] as? String,
        let description = data["description"] as? String,
        let gender = data["gender"] as? String else {return nil}
        
        self.username = username
        self.avatarStringURL = avatarStringURL
        self.id = id
        self.email = email
        self.descrtiption = description
        self.gender = gender
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let username = data["username"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let id = data["uid"] as? String,
        let email = data["email"] as? String,
        let description = data["description"] as? String,
        let gender = data["gender"] as? String else {return nil}
        
        self.username = username
        self.avatarStringURL = avatarStringURL
        self.id = id
        self.email = email
        self.descrtiption = description
        self.gender = gender
    }
    
    var representation: [String: Any] {
        var rep = ["username": username]
        rep["avatarStringURL"] = avatarStringURL
        rep["uid"] = id
        rep["email"] = email
        rep["description"] = descrtiption
        rep["gender"] = gender
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else {
            return true
        }
        if filter.isEmpty {return true}
        let lowerCaseFilter = filter.lowercased()
        return username.lowercased().contains(lowerCaseFilter)

    }
}
