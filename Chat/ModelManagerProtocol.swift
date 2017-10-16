//
//  ModelProtocol.swift
//  Chat
//
//  Created by Air on 16.10.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import Foundation

protocol ModelManagerProtocol {
    func saveData(info: ProfileInfo, completion: @escaping (_ result: Bool) -> ())
    func loadData(completion: @escaping (_ result: ProfileInfo?) -> ())
}
