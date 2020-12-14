//
//  favouriteTableViewCell.swift
//  Food2Go
//
//  Created by Liam Hector on 24/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class favouriteTableViewCell: UITableViewCell {

    //Mark Properties
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var restaurantRating: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 8
            frame.size.height -= 5
            super.frame = frame
        }
    }

}
