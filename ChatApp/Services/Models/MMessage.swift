//
//  MMessage.swift
//  ChatApp
//
//  Created by Vasichko Anna on 23.03.2022.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {
    
    let content: String
    let sentDate: Date
    let id: String?
    
    var sender: SenderType
    var messageId: String {
        id ?? UUID().uuidString
    }
    var kind: MessageKind {
        .text(content)
    }
    
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderId": sender.senderId,
            "content": content,
            "senderUsername": sender.displayName
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
        self.sentDate = sentDate.dateValue()
        self.id = document.documentID
        self.sender = Sender(senderId: senderId, displayName: senderUsername)
    }
    
    init(user: MUser, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.messageId == rhs.messageId
    }
}
