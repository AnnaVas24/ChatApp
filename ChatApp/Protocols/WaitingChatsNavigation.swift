//
//  WaitingChatsNavigation.swift
//  ChatApp
//
//  Created by Vasichko Anna on 25.03.2022.
//

import Foundation

protocol WaitingChatsNavigation: AnyObject {
    func removeWaitingChat(chat: MChat)
    func changeToActive(chat: MChat)
}
