//
//  DBManagerData.swift
//  ImageDB
//
//  Created by Motoki Onayama on 2021/06/09.
//

import Foundation

let fileURL = try! FileManager.default
   .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
   .appendingPathComponent("ImageDB.db")

class ImageModel: NSObject {
   
   var id: String?
   var image: String?
   
}
