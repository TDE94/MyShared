//
//  Feedcell.swift
//  myShare
//
//  Created by Taylan Erdogan on 27.04.2021.
//

import UIKit

class Feedcell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!

    @IBOutlet weak var notLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
