//
//  ImageViewController.swift
//  ImageDB
//
//  Created by Motoki Onayama on 2021/06/09.
//

import UIKit

protocol imageDataDelegate {
   func getImageData()
}

class ImageViewController: UIViewController, imageDataDelegate {
    func getImageData() {
           getAllData()
       }
    
    var vc = ViewController()
    
    //var vc: ViewController!
    var imageArray = [ImageModel]()
    
    @IBOutlet weak var UpLoadImageView: UIImageView! {
        didSet {
            // didSetでviewDidLoadをスッキリさせる！！
            UpLoadImageView.layer.cornerRadius = 120
            UpLoadImageView.layer.borderWidth = 1
            let border = UIColor.black.cgColor
            UpLoadImageView.layer.borderColor = border
            let profile = (vc.profileImageButton.imageView?.image!.pngData()!)! as NSData
            let base64String = profile.base64EncodedString(options: .lineLength64Characters)
            let imageData = NSData(base64Encoded: base64String, options: .ignoreUnknownCharacters)
            let image = UIImage(data: imageData! as Data)
            UpLoadImageView.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllData() // 残す
        
        // スッキリした！！
    }
    
    func getAllData() {
           let myUrl = fileURL
           print(myUrl)
           imageArray.removeAll()
           let database = FMDatabase(url: fileURL)
           if database.open() {
               
               do {
                   let rs = try database.executeQuery("select * from ImageMD", values: [0])
                   while rs.next() {
                       
                       let items : ImageModel = ImageModel()
                       items.id = rs.string(forColumn: "id")
                       items.image = rs.string(forColumn: "image")
                       imageArray.append(items)
                       //try database.executeUpdate("select * from student", values: [0])
                   }
               }
               catch {
                   print("error:\(error.localizedDescription)")
               }
           }
           else {
               print("Unable to open database")
               return
           }
           database.close()
        
       }
    
}
