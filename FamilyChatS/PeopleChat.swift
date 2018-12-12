//
//  PeopleChat.swift
//  FamilyChatS
//
//  Created by mohamed hashem on 10/19/18.
//  Copyright © 2018 mohamed hashem. All rights reserved.
//

import UIKit

class PeopleChat: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
