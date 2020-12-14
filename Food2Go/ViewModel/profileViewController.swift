//
//  ViewController.swift
//  Food2Go
//
//  Created by Prabhav Mehra on 19/08/20.
//  Copyright © 2020 Prabhav Mehra. All rights reserved.
//

import UIKit



class profileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var contactText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let TAG_1 = 1
    let TAG_2 = 2
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func addImageButton(_ sender: Any) {
        
        let image = UIImagePickerController()

        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image,animated: true){
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
        }
        else{
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     function to save the image from the profile page uploaded by the user locally in the documents directory.
     Throws an error message if file couldnt be removed iif the user changes image.
 
 
   */
    
    
    func saveImage(imageName: String, image: UIImage) {
        
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
      
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
    }
    
    /*
     
     Loads the image stored in the documents directory.
 
    */
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }
    
    /*
     Saves credentials from the profile page locally upon clicking of button.
     */
    
    @IBAction func saveCredentials(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(nameText.text, forKey: "nameText")
        defaults.set(emailText.text, forKey: "emailText")
        defaults.set(contactText.text, forKey: "contactText")
        saveImage(imageName: "test", image: imageView.image!)
        
        defaults.synchronize()
        print("fn=\(String(describing: contactText.text))")
        print("fn=\(String(describing: nameText.text))")
        print("fn=\(String(describing: emailText.text))")
    }
    
    func loadDefaults() {
        let defaults = UserDefaults.standard
       
        
        if (nameText.text!.isEmpty && emailText.text!.isEmpty && contactText.text!.isEmpty && imageView.image == nil )
        {
            let alert = UIAlertView(title: "Oops! Empty Field", message: "No Saved Fields Found.", delegate: nil, cancelButtonTitle: "OK")

            alert.show()
        }

        else {

            nameText.text = defaults.object(forKey: "nameText") as? String
            emailText.text = defaults.object(forKey: "emailText") as? String
            contactText.text = defaults.object(forKey: "contactText") as? String
            imageView.image = loadImageFromDiskWith(fileName: "test")
            
            
        }


    }
  
    @IBAction func clearButton(_ sender: Any) {
            loadDefaults()
            clearButton.setTitle("Load", for: [])
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      

        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        contactText.delegate = self
        
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        if textField == contactText {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
        

}

