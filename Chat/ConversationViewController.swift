//
//  ConversationViewController.swift
//  Chat
//
//  Created by Air on 08.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var messages =  [(text: String,id: String)]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.row].id == "in" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "incomingMessage", for: indexPath) as! ChatTableViewCell
            cell.message = messages[indexPath.row].text
            cell.messageLabel.preferredMaxLayoutWidth = tableView.frame.width * 3 / 4
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "outgoingMessage", for: indexPath) as! ChatTableViewCell
            cell.message = messages[indexPath.row].text
            cell.messageLabel.preferredMaxLayoutWidth = tableView.frame.width * 3 / 4
            return cell
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleChat()
        
        self.tableView.estimatedRowHeight = 102
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    func loadSampleChat() {
        var message = (text:"I", id: "in")
        messages.append(message)
        message = ("Hello! How are you? I'm fine!", "out")
        messages.append(message)
        
        message = ("Hello! How are you? I'm fine!", "in")
        messages.append(message)
        
        message = ("!", "out")
        messages.append(message)
        
        message = ("Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", "out")
        messages.append(message)
        
        message = ("Movie potentates were peppered across the Tower Bar here as usual on Friday night. Over in one dimly lit corner sat a martini-drinking movie star and his manager. And the restaurant’s lively owner, Jeff Klein, worked the room as he normally does, pausing to schmooze here and shake an important hand there.", "in")
        messages.append(message)
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
