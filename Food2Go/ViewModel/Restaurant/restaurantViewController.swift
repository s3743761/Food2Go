//
//  RestaurantViewController.swift
//  Food2Go
//
//  Created by Liam Hector on 29/7/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit
import os.log
import MapKit

class RestaurantViewController: UIViewController{
    
    @IBOutlet var favButton: UIButton!
    
    var flag = false
    
    //MARK: Properties
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var Distance: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantName: UINavigationItem!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var restaurant: Restaurant?

    let z = NSNull.self
    static var favResturant = [Favourites]()
    let test:[String] = []
    var defaults = UserDefaults.standard
   
    
    /*
     Adds the resturant to the favourite array when the user clicks the add to favourite button. It checks for duplicacy and only adds if the resturant dosent exsists already.
 
 
    */
    
    @IBAction func addToFavourites(_ sender: Any) {
        flag = !flag
       
        print(restaurantName.title!)

        guard let favourite1 = Favourites(name: restaurantName.title!, rating: rating.text!, image: restaurantImg.image!, distance: Distance.text!, type: foodType.text!, cost: cost.text!, latitude: restaurant!.latitude, longitude: restaurant!.longitude, phone: restaurant!.phone, location: restaurant!.address) else {
            fatalError("Unable to instantiate favourite1")
        }
        
        if !RestaurantViewController.favResturant.contains (where: { $0.name == favourite1.name }){
            RestaurantViewController.favResturant.append(favourite1)
            
        }
        

        print(RestaurantViewController.favResturant.count)



        
        var copiedArray = [String]()

        var currentIndex = 0
        
        for rest in RestaurantViewController.favResturant
        {
            
           copiedArray += [rest.name]
           currentIndex += 1
        }
        
    
        
        defaults.set(copiedArray, forKey: "SavedStringArray")
        let myarray = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
        print(myarray)
        

    
    }
    
    
    
    func deleteElement( forRowAt indexPath: IndexPath){
        RestaurantViewController.favResturant.remove(at: indexPath.row)
    }
    
    func getDeletedArray( forRowAt indexPath: Int,input:Array<String>)-> Array<String> {
       
        var copiedArray = input

        var stringArray = [String]()
        stringArray = input
        stringArray.remove(at: indexPath)
        copiedArray = stringArray
        
        return copiedArray
        
    }
    
    /*
     Returns copied array which then is used in the favouriteTableViewController.
     
    */
    
    func myArrayFunc(inputArray:Array<Favourites>) -> Array<Favourites> {
        
       
        let copiedArray = RestaurantViewController.favResturant

        return copiedArray

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favButton.setImage(UIImage(named: "fav.png"), for: .normal)

        //set up views if viewing a restaurant
        if let restaurant = restaurant {
            rating.text = "Rating: " + String(restaurant.rating)
            cost.text = "Cost: " + restaurant.cost
            Distance.text = "Distance: " + String(restaurant.distance) + "Km"
            restaurantImg.image = restaurant.photo
            restaurantName.title = restaurant.name
            foodType.text = restaurant.type
            
            phone.text = "Phone: " + restaurant.phone
            address.text = "Address: " + restaurant.address
            
            //Map details
            let location = CLLocationCoordinate2D(latitude: restaurant.latitude,
                                                  longitude: restaurant.longitude)
        
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = restaurant.name
            mapView.addAnnotation(annotation)
        }
    }

   
}
