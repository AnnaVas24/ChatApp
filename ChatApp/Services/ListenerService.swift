//
//  ListenerService.swift
//  ChatApp
//
//  Created by Vasichko Anna on 23.03.2022.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
    static let shared = ListenerService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        db.collection("users")
    }
    private var currentUserID: String {
        Auth.auth().currentUser!.uid
    }
    
    func usersObserve(users: [MUser], completion: @escaping(Result<[MUser], Error>) -> Void) -> ListenerRegistration? {
        var users = users
        let usersListener = usersRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { diff in
                guard let mUser = MUser(document: diff.document) else {return}
                switch diff.type {
                case .added:
                    guard !users.contains(mUser) else {return}
                    guard mUser.id != self.currentUserID else {return}
                    users.append(mUser)
                case .modified:
                    guard let index = users.firstIndex(of: mUser) else {return}
                    users[index] = mUser
                case .removed:
                    guard let index = users.firstIndex(of: mUser) else {return}
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    }
    
    func waitingChatsObserve(chats: [MChat], completion: @escaping(Result<[MChat], Error>) -> Void) -> ListenerRegistration? {
        var chats = chats
        let chatsRef = db.collection(["users", currentUserID, "waitingChats"].joined(separator: "/"))
    
        let chatsListener = chatsRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                guard let chat = MChat(document: diff.document) else {return}
                
                switch diff.type {
                case .added:
                    guard !chats.contains(chat) else {return}
                    chats.append(chat)
                case .modified:
                    guard let index = chats.firstIndex(of: chat) else {return}
                    chats[index] = chat
                case .removed:
                    guard let index = chats.firstIndex(of: chat) else {return}
                    chats.remove(at: index)
                }
                        
            }
            completion(.success(chats))
        }
    return chatsListener
    }
    
    func activeChatsObserve(chats: [MChat], completion: @escaping(Result<[MChat], Error>) -> Void) -> ListenerRegistration? {
        var chats = chats
        let chatsRef = db.collection(["users", currentUserID, "activeChats"].joined(separator: "/"))
    
        let chatsListener = chatsRef.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                guard let chat = MChat(document: diff.document) else {return}
                
                switch diff.type {
                case .added:
                    guard !chats.contains(chat) else {return}
                    chats.append(chat)
                case .modified:
                    guard let index = chats.firstIndex(of: chat) else {return}
                    chats[index] = chat
                case .removed:
                    guard let index = chats.firstIndex(of: chat) else {return}
                    chats.remove(at: index)
                }
                        
            }
            completion(.success(chats))
        }
    return chatsListener
    }
}
