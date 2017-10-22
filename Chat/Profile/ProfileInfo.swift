//
//  profileInfo.swift
//  Chat
//
//  Created by Air on 15.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct ProfileInfo {
    
    var notWasChanged = true
    
    var name: String
    var description: String
    
    var imageData: String?
    
    var image: UIImage?
    
    
    init(name: String, description: String, image: UIImage?, notWasChanged: Bool = true) {
        self.name = name
        self.description = description
        self.notWasChanged = notWasChanged
        self.image = image
        
        if let im = image {
            let imageData = UIImagePNGRepresentation(im)
            self.imageData = imageData?.base64EncodedString(options: .lineLength64Characters)
        } else {
            self.imageData = nil
        }
        
    }
    
    init? (json: JSON) {
        guard let name = json["name"].string, let description = json["description"].string else { return nil }
        self.name = name
        self.description = description
        self.imageData = json["image"].string
        
        let dataDecoded : Data = Data(base64Encoded: self.imageData ?? "", options: .ignoreUnknownCharacters)!
        self.image = UIImage(data: dataDecoded)
    }
    
    
    var asJSON: JSON {
        var json: JSON = [:]
        json["name"].string = name
        json["description"].string = description
        json["image"].string = imageData
        return json
    }
    
}

