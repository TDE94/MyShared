//
//  SettingsVC.swift
//  myShare
//
//  Created by Taylan Erdogan on 26.04.2021.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cikisYap(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toBack", sender: nil)
        } catch  {
            print("Hata var")
        }
    }
    

}
