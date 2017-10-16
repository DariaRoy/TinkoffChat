//
//  OperationDataManager.swift
//  Chat
//
//  Created by Air on 16.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class OperationDataManager: ModelManagerProtocol {
    
    let path = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("profileInfo")
    
    
    func saveData(info: ProfileInfo, completion: @escaping (_ result: Bool) -> () ) {
        let queue = OperationQueue()
        
        let saveDataOperation = SaveOperation(info: info, path: path) { success in
            OperationQueue.main.addOperation {
                completion(success)
            }
        }
        queue.addOperation(saveDataOperation)
    }
    
    
    func loadData(completion: @escaping (_ result: ProfileInfo?) -> ()) {

        let queue = OperationQueue()
        
        let loadDataOperation = LoadOperation(path: path) { profile in
            OperationQueue.main.addOperation {
                completion(profile)
            }
        }
        
        queue.addOperation(loadDataOperation)
        
    }
    
}

class SaveOperation: Operation {
    var info: ProfileInfo
    let completion: (Bool) -> ()
    let path : URL
    
    init(info: ProfileInfo, path: URL, completion: @escaping (_ success: Bool) -> ()) {
        self.completion = completion
        self.info = info
        self.path = path
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        do {
            if info.notWasChanged == true {
                    completion(true)
            } else {
                let json = self.info.asJSON
                let data = try json.rawData()
                try data.write(to: self.path)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
}

class LoadOperation: Operation {
    
    var completion: (ProfileInfo?) -> ()
    let path : URL
    
    
    init(path: URL, completion: @escaping (_ profile:ProfileInfo?) -> ()) {
        self.completion = completion
        self.path = path
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        do {
            let data =  try Data(contentsOf: self.path)
            let newJson = JSON(data: data)
            if let profile = ProfileInfo(json: newJson) {
                completion(profile)
            } else {
                completion(nil)
            }
        } catch {
                completion(nil)
        }
    }
}
