//
//  UploadVC.swift
//  myShare
//
//  Created by Taylan Erdogan on 26.04.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var notText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRec)
        
    }
    @objc func gorselSec(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func uploadButon(_ sender: Any) {
        
        let storage = Storage.storage()
        let storegaRef = storage.reference()
        let mediaFolder = storegaRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid  = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { (metadata, hata) in
                if hata != nil {
                    print(hata?.localizedDescription ?? "Hata var tırrek")
                }else{
                    imageRef.downloadURL { (url, hata) in
                        if hata == nil{
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl{
                                
                                let firestore = Firestore.firestore()
                                let firestorePost = ["gorselUrl":imageUrl,"email" : Auth.auth().currentUser?.email!,"time":FieldValue.serverTimestamp(),"not":self.notText.text!] as [String:Any?]
                                
                             firestore.collection("Posts").addDocument(data: firestorePost as [String : Any]) { (hata) in
                                    if hata != nil {
                                        self.hataMesajı(titleText: "Hata", mesajText: "Hata")
                                    }else{
                                        self.performSegue(withIdentifier: "toFeedBack", sender: nil)
                                    }
                                }
                                
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
    func hataMesajı(titleText:String,mesajText:String){
        let alert = UIAlertController(title: titleText, message: mesajText, preferredStyle: UIAlertController.Style.alert)
        
        let okButon = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    

    }
    
   

}
