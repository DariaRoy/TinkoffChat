//
//  ChatTableViewCell.swift
//  Chat
//
//  Created by Air on 08.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    
    var message: String? {
        didSet {
            messageLabel.text = message
        }
    }

    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
