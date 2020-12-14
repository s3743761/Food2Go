//
//  RestaurantTableViewCell.swift
//  Food2Go
//
//  Created by Liam Hector on 19/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
//MARK Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
