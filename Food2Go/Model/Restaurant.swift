//
//  Restaurant.swift
//  Food2Go
//
//  Created by Liam Hector on 19/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

/*
Restaurant Model class for creating restaurant objects and storiing values gathered from the yelp api
*/

import UIKit

struct Restaurant {
    var photo: UIImage?
    var name: String
    var type: String
    var distance: Double
    var cost: String
    var rating: Float
    var latitude: Double
    let longitude: Double
    let phone: String
    let address: String
}


