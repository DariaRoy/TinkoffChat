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
        let current = Date(timeIntervalSinceNow: 0)
        return getDate(date: getDateTuple(date: self.date!), current: getDateTuple(date: current))
    }
    
}


func getDateTuple(date: Date) -> (year: Int, month: Int, day: Int, hour: Int,minute: Int, monthMMM: String) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss +zzzz"
    
    let monthFormatter = DateFormatter()
    monthFormatter.dateFormat = "MMM"
    let monthMMM = monthFormatter.string(from: date)
    
    let calendar = Calendar.current
    let comp = calendar.dateComponents([.hour, .minute, .day, .month, .year], from: date)
    let day = comp.day!
    let month = comp.month!
    let year = comp.year!
    let hour = comp.hour!
    let minute = comp.minute!
    
    return (year, month, day, hour, minute, monthMMM)
    
}


func getDate (date: (year: Int, month: Int, day: Int, hour: Int, minute: Int, monthMMM: String), current: (year: Int, month: Int, day: Int, hour: Int,minute: Int, monthMMM: String) ) -> String {
    
    if date.year < current.year || date.year == current.year && date.month < current.month || date.year == current.year && date.month == current.month && date.day < date.day {
        return "\(date.day) \(date.monthMMM)"
    } else {
        let zero = date.minute < 10 ? "0" : ""
        return "\(date.hour):\(zero)\(date.minute)"
    }
    
}
