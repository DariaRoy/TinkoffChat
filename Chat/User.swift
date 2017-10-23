//
//  User.swift
//  Chat
//
//  Created by Air on 22.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import Foundation

class User {
    
    var ID: String?
    
    var name: String?
    
    var messages : [(text: String,id: String)]
    
    var online: Bool = false
    
    var hasUnreadMessages: Bool = false
    
    init(ID: String?, name: String?, messages: [(text: String,id: String)]?, online: Bool, hasUnreadMessages: Bool) {
        self.ID = ID
        self.name = name
        self.messages = messages ?? []
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
    }
    
}
