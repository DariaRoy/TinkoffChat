//
//  CommunicationManager.swift
//  Chat
//
//  Created by Air on 22.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import Foundation



class CommunicatorManager: CommunicatorDelegate {
    
    var communicator = MultipeerCommunicator()
    var delegateList: ConversationsListViewController?
    
    
    init() {
        communicator.delegate = self
    }
    
    
    //discovering
    func didFoundUser(userID: String, userName: String?) {
        if let name = userName {
            delegateList?.addUser(name: name, ID: userID)
        } else {
            delegateList?.addUser(name: "error", ID: userID)
        }
        communicator.sendMessage(string: "fe", to: userName, completionHandler: nil)
    }
    
    func didLostUser(userID: String) {
        
    }
    
    //errors
    func failedToStartBrosingForUsers(error: Error) {
        print(error)
    }
    func failedToStartAdvertising(error: Error) {
        print(error)
    }
    
    
    //messages
    func didReceiveMessage(text: String, fromUser: String, toUser:String) {
        
    }
    
}





protocol CommunicatorDelegate: class {
    //discovering
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
    
    //errors
    func failedToStartBrosingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    //messages
    func didReceiveMessage(text: String, fromUser: String, toUser:String)
}


