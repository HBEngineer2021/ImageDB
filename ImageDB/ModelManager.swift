//
//  ModelManager.swift
//  ImageDB
//
//  Created by Motoki Onayama on 2021/06/22.
//

import Foundation
import UIKit

var shareInstance = ModelManager()

class ModelManager {
    
    var database: FMDatabase? = nil
    
    static func getInstance() -> ModelManager {
        if shareInstance.database == nil {
            shareInstance.database = FMDatabase(path: Util.share.getPath(dbName: "dbName.db"))
        }
        return shareInstance
    }
    func Save(model: Model) -> Bool {
        shareInstance.database?.open()
        
        let isSave = shareInstance.database?.executeUpdate("INSERT INTO table(column) VALUES(?)", withArgumentsIn: [model.column])
        
        shareInstance.database?.close()
        return isSave!
    }
}
