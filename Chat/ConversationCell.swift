//
//  ConversationCell.swift
//  Chat
//
//  Created by Air on 08.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import Foundation


struct ConversationCell {
    
    var name: String?
    
    var message: String?
    
    var date: Date?
    
    var online: Bool
    
    var hasUnreadMessages: Bool
    
    func dateInString() -> String {
        if NSCalendar.current.isDateInToday(date!) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date!)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM"
            return formatter.string(from: date!)
        }
    }
}

