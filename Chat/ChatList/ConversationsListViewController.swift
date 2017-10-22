//
//  ConversationsListViewController.swift
//  Chat
//
//  Created by Air on 08.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var chats = [[ConversationCell]]()
    
    ////
    
    
    //let st = MultipeerCommunicator()
    var communicationManage = CommunicatorManager()
    
    
    ////
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chats.count > 0 {
             return chats[section].count
        } else {
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Online" : "History"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Conversation", for: indexPath)
        
        if let mycell = cell as? ConversationTableViewCell {
            mycell.conversationCell = chats[indexPath.section][indexPath.row]
        }
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadSampleChats()
        
        communicationManage.delegateList = self
        
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    func addUser(name: String, ID:String) {
        var chat = [ConversationCell]()
        let chat1 = ConversationCell(name: name, message: nil, date: Date(timeIntervalSinceNow: 0), online: true, hasUnreadMessages: true)
        chat.append(chat1)
        chats.append(chat)
        tableView.reloadData()
    }
    
    
    
    private func loadSampleChats() {
        var chatsOnline = [ConversationCell]()
        
        let chatOnline1 = ConversationCell(name: "Ben", message: "Hello", date: Date(timeIntervalSinceNow: -65578098), online: true, hasUnreadMessages: false)
        chatsOnline.append(chatOnline1)
        
        
        let chatOnline2 = ConversationCell(name: "Bob", message: "Hello it's me fsdfffsd fdsfdsf fsdfsdfs fdfsf", date: Date(timeIntervalSinceNow: -943543), online: true, hasUnreadMessages: true)
        chatsOnline.append(chatOnline2)
        
        let chatOnline3 = ConversationCell(name: "Cris", message: nil, date: Date(timeIntervalSinceNow: -43543), online: true, hasUnreadMessages: false)
        chatsOnline.append(chatOnline3)
        
        let chatOnline4 = ConversationCell(name: "Kate", message: nil, date: Date(timeIntervalSinceNow: -435493), online: true, hasUnreadMessages: false)
        chatsOnline.append(chatOnline4)
        
        
        let chatOnline5 = ConversationCell(name: "Mary", message: "Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", date: Date(timeIntervalSinceNow: -435643), online: true, hasUnreadMessages: false)
        chatsOnline.append(chatOnline5)
        
        
        let chatOnline6 = ConversationCell(name: "Alex", message: "Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", date: Date(timeIntervalSinceNow: -435477), online: true, hasUnreadMessages: true)
        chatsOnline.append(chatOnline6)
        
        let chatOnline7 = ConversationCell(name: "Alex", message: nil, date: Date(timeIntervalSinceNow: -535346), online: true, hasUnreadMessages: false)
        chatsOnline.append(chatOnline7)
        
        
        let chatOnline8 = ConversationCell(name: "Flex", message: "Hi", date: Date(timeIntervalSinceNow: -59384953), online: true, hasUnreadMessages: true)
        chatsOnline.append(chatOnline8)
        
        let chatOnline9 = ConversationCell(name: "Nina", message: "And the restaurant’s lively owner, Jeff Klein", date: Date(timeIntervalSinceNow: -21), online: true, hasUnreadMessages: true)
        chatsOnline.append(chatOnline9)
        
        
        let chatOnline10 = ConversationCell(name: "Stiv", message: nil, date: Date(timeIntervalSinceNow: -2987), online: true, hasUnreadMessages: false)
        chatsOnline.append(chatOnline10)
        
        
        
        var chatsHistory = [ConversationCell]()
        let chatHistory1 = ConversationCell(name: "Alice", message: "Hello", date: Date(timeIntervalSinceNow: -3543), online: false, hasUnreadMessages: false)
        chatsHistory.append(chatHistory1)
        
        let chatHistory2 = ConversationCell(name: "Mike", message: "Yes", date: Date(timeIntervalSinceNow: -543), online: false, hasUnreadMessages: true)
        chatsHistory.append(chatHistory2)
        
        let chatHistory3 = ConversationCell(name: "Bill", message: nil, date: Date(timeIntervalSinceNow: -43), online: false, hasUnreadMessages: false)
        chatsHistory.append(chatHistory3)
        
        let chatHistory4 = ConversationCell(name: "Megan", message: "Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", date: Date(timeIntervalSinceNow: -435789743), online: false, hasUnreadMessages: true)
        chatsHistory.append(chatHistory4)
        
        let chatHistory5 = ConversationCell(name: "Karl", message: "Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", date: Date(timeIntervalSinceNow: -8743543), online: false, hasUnreadMessages: false)
        chatsHistory.append(chatHistory5)
        
        let chatHistory6 = ConversationCell(name: "Inga", message: "And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", date: Date(timeIntervalSinceNow: -490343), online: false, hasUnreadMessages: false)
        chatsHistory.append(chatHistory6)
        
        let chatHistory7 = ConversationCell(name: "Gomer", message: "And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", date: Date(timeIntervalSinceNow: -439033), online: false, hasUnreadMessages: true)
        chatsHistory.append(chatHistory7)
        
        let chatHistory8 = ConversationCell(name: "Bart", message: nil, date: Date(timeIntervalSinceNow: -4390443), online: false, hasUnreadMessages: false)
        chatsHistory.append(chatHistory8)
        
        let chatHistory9 = ConversationCell(name: "Liza", message: "WOW", date: Date(timeIntervalSinceNow: -99433343), online: false, hasUnreadMessages: true)
        chatsHistory.append(chatHistory9)
        
        
        let chatHistory10 = ConversationCell(name: "Grandpa", message: "yes", date: Date(timeIntervalSinceNow: -473343), online: false, hasUnreadMessages: true)
        chatsHistory.append(chatHistory10)
        
        chats.append(chatsOnline)
        chats.append(chatsHistory)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "Show chat" {
            var destinationViewController = segue.destination
            if let navigationViewController = destinationViewController as? UINavigationController {
                destinationViewController = navigationViewController.visibleViewController ?? destinationViewController
            }
            
            if let conversationViewController = destinationViewController as? ConversationViewController {
                conversationViewController.navigationItem.title = (sender as? ConversationTableViewCell)?.nameLabel.text
            }
        }
        
    }


}
