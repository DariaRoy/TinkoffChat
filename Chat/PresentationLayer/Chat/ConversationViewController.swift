//
//  ConversationViewController.swift
//  Chat
//
//  Created by Air on 08.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var user: User?
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    var textCurrentMessage: String?
    
    @IBAction func tapSendButton(_ sender: UIButton) {
        if let text =  textCurrentMessage {
            communicationManage?.communicator.sendMessage(string: text, to: user?.ID, completionHandler: nil)
            user?.messages.append((text: text, id: "out"))
            tableView.reloadData()
        }
    }
    
    //var messages =  [(text: String,id: String)]()
    var communicationManage: CommunicatorManager?

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.messages.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if user?.messages[indexPath.row].id == "in" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "incomingMessage", for: indexPath) as! ChatTableViewCell
            
            cell.message = user?.messages[indexPath.row].text
            cell.messageLabel?.preferredMaxLayoutWidth = view.frame.width * 0.75
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "outcomingMessage", for: indexPath) as! ChatTableViewCell
            
            cell.message = user?.messages[indexPath.row].text
            cell.messageLabel?.preferredMaxLayoutWidth = view.frame.width * 0.75
            return cell
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadSampleChat()

        textField.delegate = self
        //messages = user?.messages ?? []

        communicationManage?.delegateChat = self
        
        self.tableView.estimatedRowHeight = 102
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    func didReceiveMessage(text: String) {
        user?.messages.append((text: text, id: "in"))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
   
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the Save button while editing.
        //saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        textCurrentMessage = textField.text
        
    }
    
    
//    func loadSampleChat() {
//        var message = (text:"I", id: "in")
//        messages.append(message)
//        message = ("Hello! How are you? I'm fine!", "out")
//        messages.append(message)
//
//        message = ("Hello! How are you? I'm fine!", "in")
//        messages.append(message)
//
//        message = ("!", "out")
//        messages.append(message)
//
//        message = ("Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", "out")
//        messages.append(message)
//
//        message = ("Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", "in")
//        messages.append(message)
//
//    }
}
