//
//  MMessage.swift
//  ChatApp
//
//  Created by Vasichko Anna on 23.03.2022.
//

import UIKit
import FirebaseFirestore
import MessageKit


struct ImageItem: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}

struct MessageSender: SenderType {
    var senderId: String
    
    var displayName: String
}

struct MMessage: Hashable, MessageType {
    
    let content: String
    let sentDate: Date
    let id: String?
    
    var sender: SenderType
   
    var messageId: String {
        id ?? UUID().uuidString
    }
    var kind: MessageKind {
        if let image = image {
            let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
            return .photo(mediaItem)
        } else {
            return .text(content)
        }
    }
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderId": sender.senderId,
            "senderUsername": sender.displayName
        ]
        if let url = downloadURL {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        return rep
    }
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderUsername = data["senderUsername"] as? String,
              let senderId = data["senderId"] as? String,
        let sentDate = data["created"] as? Timestamp else {return nil}
        
        self.sentDate = sentDate.dateValue()
        self.id = document.documentID
        self.sender = MessageSender(senderId: senderId, displayName: senderUsername)
        
        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString){
            downloadURL = url
            self.content = ""
        } else {
            return nil
        }
    }
    
    init(user: MUser, content: String) {
        self.content = content
        sender = MessageSender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    init(user: MUser, image: UIImage) {
        sender = MessageSender(senderId: user.id, displayName: user.username)
        self.image = image
        content = ""
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

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.sentDate < rhs.sentDate
    }
    
}
