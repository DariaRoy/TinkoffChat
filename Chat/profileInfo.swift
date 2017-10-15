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
    
    let name: String
    let description: String
    let imageData: String?
    
    var image: UIImage? {
        get {
            let dataDecoded : Data = Data(base64Encoded: self.imageData ?? "", options: .ignoreUnknownCharacters)!
            
            return UIImage(data: dataDecoded)
        }
    }
    
    
    init(name: String, description: String, image: UIImage?) {
        self.name = name
        self.description = description
        if let im = image {
            let imageData = UIImagePNGRepresentation(im)
            self.imageData = imageData?.base64EncodedString(options: .lineLength64Characters)
        } else {
            self.imageData = nil
        }
        
    }
    
    init? (json: JSON) {
        guard let name = json["name"].string, let description = json["description"].string else {return nil}
        self.name = name
        self.description = description
        self.imageData = json["image"].string
    }
    
    
    var asJSON: JSON {
        var json: JSON = [:]
        json["name"].string = name
        json["description"].string = description
        json["image"].string = imageData
        return json
    }
    
}

