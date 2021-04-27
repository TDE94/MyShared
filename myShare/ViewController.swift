//
//  ViewController.swift
//  myShare
//
//  Created by Taylan Erdogan on 26.04.2021.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var sifreText: UITextField!
    @IBOutlet weak var emailText: UITextField!
        override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func girisYap(_ sender: Any) {
        if emailText.text != "" && sifreText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: sifreText.text!) { (dataResult, hata) in
                if hata != nil {
                    self.hataMesajı(titleText: "Hata", mesajText: hata?.localizedDescription ?? "Bilinmeyen hata oluştu")
                }else{
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        }else{
            hataMesajı(titleText: "Hata", mesajText: "Kullanıcı adı ve şifre boş")
        }
        
      
           
        }
    @IBAction func kayitOl(_ sender: Any) {
        if emailText.text != "" && sifreText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: sifreText.text!) { (authResult, hata) in
                if hata != nil {
                    self.hataMesajı(titleText: "hata var", mesajText: hata?.localizedDescription ?? "Hata bulundu")
                }else{
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
            
        }else{
            hataMesajı(titleText: "Hata", mesajText: "Kullanıcı adı ve şifre boş olamaz")
        }
            }
        
    
    
    func hataMesajı(titleText:String,mesajText:String){
        let alert = UIAlertController(title: titleText, message: mesajText, preferredStyle: UIAlertController.Style.alert)
        
        let okButon = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButon)
        self.present(alert, animated: true, completion: nil)
    

    }
    }
    


