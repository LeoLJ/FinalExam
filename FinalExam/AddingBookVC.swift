//
//  AddingBookVC.swift
//  FinalExam
//
//  Created by Leo on 7/22/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddingBookVC: UIViewController {
    
    @IBOutlet weak var bookNameField: UITextField!
    
    @IBOutlet weak var bookSummaryField: UITextField!
    
    @IBOutlet weak var storeAddreField: UITextField!
    
    @IBOutlet weak var storeWebField: UITextField!

    @IBOutlet weak var storeTelField: UITextField!
    
    @IBOutlet weak var smallImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addToFireBase(sender: AnyObject) {
        //Firebase url:"https://acfinalexam-a371f.firebaseio.com/"
       
        let image = self.smallImage?.image
        let imageData = UIImageJPEGRepresentation(image!, 1.0)
        let imageString = imageData?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        
        
        let ref = FIRDatabase.database().reference()
        let childRef = ref.child("myBooks").childByAutoId()
        let value = ["bookName":bookNameField.text!,
                     "bookSummury": bookSummaryField.text!,
                     "storeAddress":storeAddreField.text!,
                     "storeTel": storeTelField.text!,
                     "storeWebsite": storeWebField.text!,
                     "bookImage": imageString!]
        
        childRef.setValue(value)
        
        self.bookNameField.text = nil
        self.bookSummaryField.text = nil
        self.storeAddreField.text = nil
        self.storeTelField.text = nil
        self.storeWebField.text = nil
//        self.smallImage!.image = UIImage(named: "chat_sympton")
    }
    


}

//MARK TAKE A PHOTO
extension AddingBookVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("info \(info)")
        let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
//        image?.resizeWith(0.5)
//        image?.resizeWithWidth(400)
        self.smallImage!.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func takePhoto(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}
