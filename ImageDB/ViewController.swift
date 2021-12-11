//
//  ViewController.swift
//  ImageDB
//
//  Created by Motoki Onayama on 2021/06/09.
//

import UIKit
import FMDB

class ViewController: UIViewController {
    
    var isEdit = false
    var id: String?
    var image: UIImage?
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var UpLoadButton: UIButton!
    
    var imageDelegate: imageDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEdit == true {
            profileImageButton.imageView?.image = image
        }
        profileImageButton.layer.cornerRadius = 120
        profileImageButton.layer.borderWidth = 1
        let border = UIColor.black.cgColor
        profileImageButton.layer.borderColor = border
        profileImageButton.addTarget(self, action: #selector(tappedProfileImageButton), for: .touchUpInside)
        let backgroud = UIColor.cyan.cgColor
        UpLoadButton.layer.backgroundColor = backgroud
        UpLoadButton.layer.cornerRadius = 10
        
    }
    
    func updateImageData() {
           let database = FMDatabase(url: fileURL)
           guard database.open() else {
               print("Not fetch database")
               return
           }
           do {
               //name TEXT, email TEXT, college TEXT, faculty TEXT, branch TEXT, timestamp TEXT
            try database.executeUpdate("UPDATE student SET image =? where id ='\(id!)'", values: [profileImageButton.imageView?.image! ?? String.self])
           }
           catch let error {
               print(error.localizedDescription)
           }
           database.close()
           imageDelegate?.getImageData()
           self.navigationController?.popViewController(animated: true)
       }
       
    func insertChatToDB(image: String) {
           let database = FMDatabase(url: fileURL)
           guard database.open() else {
               print("Unable to open database")
               return
           }
           do {
               
            try database.executeUpdate("INSERT INTO ImageMD(image) values (?)", values: [image])
               
           }
           
           catch {
               print("\(error.localizedDescription)")
           }
           database.close()
           imageDelegate?.getImageData()
        
           self.navigationController?.popViewController(animated: true)
           
       }
    
    @IBAction func addImageTapped(_ sender: Any) {
        let profile = (profileImageButton.imageView?.image!.pngData()!)! as NSData
        let base64String = profile.base64EncodedString(options: .lineLength64Characters)
        print(base64String)
        insertChatToDB(image: base64String)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "toSecond") as? ImageViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        //self.performSegue(withIdentifier: "toSecond", sender: nil)
    }
    
    @objc private func tappedProfileImageButton() {
        if isEdit == true {
            updateImageData()
        }
        print("tappedProfileImageButton")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editingImage = info[.editedImage] as? UIImage {
            profileImageButton.setImage(editingImage.withRenderingMode(.alwaysOriginal), for: .normal) } else if let originalImage = info[.originalImage] as? UIImage {
                profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        profileImageButton.setTitle("", for: .normal)
        profileImageButton.imageView?.contentMode = .scaleAspectFill
        profileImageButton.contentHorizontalAlignment = .fill
        profileImageButton.contentVerticalAlignment = .fill
        profileImageButton.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
        
    }
}
