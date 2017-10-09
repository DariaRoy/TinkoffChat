//
//  ConversationTableViewCell.swift
//  Chat
//
//  Created by Air on 08.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
    
    var conversationCell: ConversationCell? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    func updateUI(){
        
        nameLabel.text = conversationCell?.name
        
        if let message = conversationCell?.message {
            messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
            messageLabel.text = message
        } else {
            messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
            messageLabel.text = "No messages yet"
        }
        
        timeLabel.text = conversationCell?.dateInString()
        
        if conversationCell?.online == true {
            self.backgroundColor = UIColor(red:0.94, green:0.86, blue:0.51, alpha:1.0)
        } else {
            self.backgroundColor = UIColor.white
        }
        
        if conversationCell?.hasUnreadMessages == true && conversationCell?.message != nil {
            self.messageLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        } else {
            if conversationCell?.message != nil {
                messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
            }
        }
            
            
    }

}



