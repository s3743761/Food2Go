//
//  Favourites.swift
//  Food2Go
//
//  Created by David Nguyen on 26/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

/*
 Favourties Model class for makiing favouriites object and storing favourite restaunrants.
 
 */

class Favourites {
    // Mark properties
    var name: String
    var rating: String
    var image: UIImage
    var distance: String
    var type: String
    var cost: String
    var latitude: Double
    var longitude: Double
    var phone: String
    var location: String
    
    //MARK Initialization
    init?(name: String, rating: String, image: UIImage, distance: String, type: String, cost: String, latitude: Double, longitude: Double, phone: String, location: String){
        
      
        if name.isEmpty {
            return nil
        }
        
        //Initialize stored properties
        self.name = name
        self.rating = rating
        self.image = image
        self.distance = distance
        self.type = type
        self.cost = cost
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.location = location

    }

    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let rating = aDecoder.decodeObject(forKey: "rating") as! String
        let image = aDecoder.decodeObject(forKey: "image") as! UIImage
        let distance = aDecoder.decodeObject(forKey: "distance") as! String
        let type = aDecoder.decodeObject(forKey: "type") as! String
        let cost = aDecoder.decodeObject(forKey: "cost") as! String
        let latitude = aDecoder.decodeObject(forKey: "latitude") as! Double
        let longitude = aDecoder.decodeObject(forKey: "longitude") as! Double
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        let location = aDecoder.decodeObject(forKey: "location") as! String
       
        self.init( name: name, rating: rating, image: image, distance: distance, type: type, cost: cost, latitude: latitude, longitude: longitude, phone: phone, location: location)!
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(name, forKey: "image")
        aCoder.encode(rating, forKey: "distance")
        aCoder.encode(name, forKey: "type")
        aCoder.encode(rating, forKey: "cost")
        aCoder.encode(name, forKey: "latitude")
        aCoder.encode(rating, forKey: "longitude")
        aCoder.encode(name, forKey: "phone")
        aCoder.encode(rating, forKey: "location")
    }

   
}
