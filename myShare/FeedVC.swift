//
//  FeedVC.swift
//  myShare
//
//  Created by Taylan Erdogan on 26.04.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var postDizi = [Post]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom",for: indexPath) as! Customcell
        cell.emailLabel.text = postDizi[indexPath.row].email
        cell.notLabel.text = postDizi[indexPath.row].not
        cell.postImage?.sd_setImage(with: URL(string: postDizi[indexPath.row].gorselUrl))
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        verileriAl()

        // Do any additional setup after loading the view.
    }
    
    func verileriAl(){
        let firestore = Firestore.firestore()
        firestore.collection("Posts").addSnapshotListener { (snapshot, hata) in
            if hata != nil {
                print("hata")
            }else{
                if snapshot != nil && snapshot?.isEmpty != true {
                    self.postDizi.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        if let mail = document.get("email") as? String{
                            if let gorselUrl = document.get("gorselUrl") as? String{
                                if let not = document.get("not") as? String{
                                    let post = Post(email:mail , not: not, gorselUrl: gorselUrl)
                                    self.postDizi.append(post)
                                }
                            }

                        }
                       
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }

}
