//
//  favouritesViewController.swift
//  Food2Go
//
//  Created by Liam Hector on 19/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//
import UIKit
import SafariServices
import MapKit

class favouritesViewController: UIViewController, UITextFieldDelegate {
    
    //Mark Properties
    @IBOutlet weak var restaurantName: UINavigationItem!
    @IBOutlet weak var restaurantRating: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantDistance: UILabel!
    @IBOutlet weak var restauarantType: UILabel!
    @IBOutlet weak var restaurantCost: UILabel!
    @IBOutlet weak var restaurantphone: UILabel!
    @IBOutlet weak var restaurantaddress: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    /*
     This value is either passed by `favouriteTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new favourite.
     */
    var favourite: Favourites?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let favourite = favourite {
            restaurantName.title = favourite.name
            restaurantRating.text = favourite.rating
            restaurantImage.image = favourite.image
            restaurantDistance.text = favourite.distance
            restauarantType.text = favourite.type
            restaurantCost.text = favourite.cost
            restaurantphone.text = favourite.phone
           restaurantaddress.text = favourite.location
            
            //Map details
            let location = CLLocationCoordinate2D(latitude: favourite.latitude,
                                                  longitude: favourite.longitude)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = favourite.name
            mapView.addAnnotation(annotation)
        }
        
    }
    
    
    
}

