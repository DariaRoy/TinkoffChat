//
//  GCDDataManager.swift
//  Chat
//
//  Created by Air on 14.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class GCDDataManager {
    
    let path = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("profileInfo")
    
    func saveData(info: ProfileInfo, completion: @escaping (_ result: Bool) -> () ) {
        DispatchQueue.global().async {
            do {
                if info.wasChanged == true {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } else {
                    let json = info.asJSON
                    let data = try json.rawData()
                    try data.write(to: self.path)
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func loadData(completion: @escaping (_ result: ProfileInfo?) -> ()) {
        DispatchQueue.global().async {
            do {
                let data =  try Data(contentsOf: self.path)
                let newJson = JSON(data: data)
                if let profile = ProfileInfo(json: newJson) {
                    DispatchQueue.main.async {
                        completion(profile)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
}

