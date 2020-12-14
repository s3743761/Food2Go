//
//  restaurantTableViewController.swift
//  Food2Go
//
//  Created by Liam Hector on 19/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit
import os.log
import CoreLocation

protocol Refresh{
    func updateUI()
}
class restaurantTableViewController: UITableViewController, CLLocationManagerDelegate {
    //MARK: Properties
    private let session = URLSession.shared
    var delegate: Refresh?
    var restaurants = [Restaurant]()
    var locationManager = CLLocationManager()
    var latitude:  Double = 0
    var longitude:  Double = 0
    var count = 0

  

    override func viewDidLoad() {
        super.viewDidLoad()
       
                self.refreshControl = UIRefreshControl()
                self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
                self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
                self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
        getRestaurant()
        
    }
    
    /*
     Refreshes the home page upon pulling the screen. The list of resturants changes if the location of the user changes.
     
     
    */
    
    @objc func refresh(sender:AnyObject) {
       determineMyCurrentLocation()
        getRestaurant()
        self.tableView.reloadData()
        
        self.refreshControl!.endRefreshing()
    }
    /*
     
     Uses apple corelocation framework to get users current location.
 

    */
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
           
        }
    }
    
    public func setLocation(value: Double){
        longitude = value
    }
    
    public func getLocation(double: Double) -> Double{
        return double
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
       
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RestaurantTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                      for: indexPath) as? RestaurantTableViewCell else {
                                                        fatalError("The dequeued cell is not an instance of RestuarantTable ViewCell.")
        }
        //fetched the appropriate resturant for the data source layout.
        let restaurant = restaurants[indexPath.row]
       
        
        cell.photoImageView.image = restaurant.photo
        cell.nameLabel.text = restaurant.name
        cell.typeLabel.text = restaurant.type
        cell.distanceLabel.text = "Distance: " + String(restaurant.distance) + "Km"
        cell.costLabel.text = "Cost: " + restaurant.cost
        cell.ratingLabel.text = "Rating: " + String(restaurant.rating)
        

        return cell
    }


   
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        super.prepare(for: segue, sender: sender)
       
        switch(segue.identifier ?? ""){
       
        case "ShowDetail":
            guard let restaurantDetailViewController = segue.destination as? RestaurantViewController
                else {
                    fatalError("unexpected destination: \(segue.destination)")
                    
            }
            
            guard let selectedRestaurantCell = sender as? RestaurantTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedRestaurantCell) else {
                fatalError("The selected Cell is not being displayed buy the table")
            }
            
            let selectedRestaurant = restaurants[indexPath.row]
            restaurantDetailViewController.restaurant = selectedRestaurant
            
        
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
 
    //MARK: Private Methods
    /*
     Connects to the yelp api using the current location of user. Uses the "GET" mapping and gets all the data from the api which
     is related to resturant information.
 
    */

    
    private func getRestaurant() {

    
        let base_url:String = "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&locale=en_AU"
        let url = base_url
        
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let url = URL(string: escapedAddress!)
        {
            var request = URLRequest(url: url)
            request.setValue("Bearer \("m6zc6ykH0ExBpRuZ6iJlritn-922o7X5zS9_EItBG3R3yGkFHFibKOIOGPKyfXifjP9y_vXdRyURl4NCdiyQu2oq6rCdrX66v1f1Jn4TuxmNNhVPshuFC0CheK56X3Yx")", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            getData(request, element: "businesses")
        }
    }
    
    /*
 
     Stores the data in session in arrays which is gathered from the api.
 
    */
    func getData(_ request: URLRequest, element: String)
    {
        let task = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if let error = downloadError
            {
                print(error)
            }
            else
            {
                var parsedResult: Any! = nil
                do
                {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch{
                    print()
                }
                
                let result = parsedResult as! [String:Any]
                
                if result[element] == nil {
                    return
                }
                
                //print(result)
                let allRestaurants = result[element] as! [[String:Any]]
                print(allRestaurants)
                if allRestaurants.count > 0
                {
                    self.restaurants.removeAll()
                    for r in allRestaurants
                    {
                        
                        let title = r["name"] as! String
                        let rating = r["rating"] as! Float
                        
                        var price: String = "-"
                        if r["price"] != nil {
                            price = r["price"] as! String
                        }
                        
                        let distance = r["distance"] as! Double
                        let imageName = r["image_url"] as! String?
                        let disKM = distance/1000
                        let dis = (disKM*100).rounded()/100
                        
                        let coordinates = r["coordinates"] as AnyObject
                        let userLatitude = coordinates["latitude"] as! Double
                        let userLongitude = coordinates["longitude"] as! Double
                        let phone = r["display_phone"] as! String
                        
                        let categories = r["categories"] as AnyObject
                        var type: String = "-"
                        for c in categories as! [AnyObject]{
                            type = c["title"] as! String
                        }
                        
                        let location = r["location"] as AnyObject
                        let address = (location["address1"] as! String) + " " + (location["city"] as! String)

                        var image:UIImage? = nil
                        
                        if (imageName?.count)! > 0
                        {
                            if let thumbnail = imageName
                            {
                                let imageUrl = URL(string: thumbnail)!
                                let data = try? Data(contentsOf: imageUrl)
                                
                                if let imageData = data {
                                    image = UIImage(data: imageData)
                                }
                                let restaurant = Restaurant(photo: image, name: title, type: type , distance: dis, cost: price, rating: rating, latitude: userLatitude, longitude: userLongitude, phone: phone, address: address)
                                
                                self.restaurants += [restaurant]
                                
                            }
                        }
                       print()
                        DispatchQueue.main.async(execute: {
                            self.tableView.reloadData()
                        })
                    }

                }
                else{
                    self.restaurants.append(Restaurant(photo: UIImage(named:""), name: "No Data", type: "Type", distance: 1, cost: "", rating: 0, latitude: 0, longitude: 0, phone: "",  address: ""))
                }
                
                DispatchQueue.main.async(execute:{
                    self.delegate?.updateUI()
                })
                
                
            }
            
        })
        task.resume()
       
    }
    
   func getNumberOfElements(_ request: URLRequest, element: String){
     
        
    _ = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if let error = downloadError
            {
                print(error)
            }
            else
            {
                var parsedResult: Any! = nil
                do
                {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch{
                    print()
                }
                
                let result = parsedResult as! [String:Any]
                
                //print(result)
                let allRestaurants = result[element] as! [[String:Any]]
                self.count = allRestaurants.count
                print(allRestaurants)
            }
           
        })

    }
    
    public func getCount(double: Int) -> Int{
        return count
    }
    
    
    
    

    
}

