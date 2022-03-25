//
//  MMessage.swift
//  ChatApp
//
//  Created by Vasichko Anna on 23.03.2022.
//

import UIKit
import FirebaseFirestore

struct MMessage: Hashable {
    let content: String
    let senderUsername: String
    let senderId: String
    let sentDate: Date
    let id: String?
    
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderId": senderId,
            "content": content,
            "senderUsername": senderUsername
        ]
        return rep
    }
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let content = data["content"] as? String,
        let senderUsername = data["senderUsername"] as? String,
        let senderId = data["senderId"] as? String,
        let sentDate = data["created"] as? Timestamp else {return nil}
        
        self.content = content
        self.senderUsername = senderUsername
        self.senderId = senderId
        self.sentDate = sentDate.dateValue()
        self.id = document.documentID
    }
    
    init(user: MUser, content: String) {
        self.content = content
        senderId = user.id
        senderUsername = user.username
        sentDate = Date()
        id = nil
    }
}
