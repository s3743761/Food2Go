//
//  exploreViewController.swift
//  Food2Go
//
//  Created by Liam Hector on 19/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit
import MapKit

class exploreViewController: UIViewController {
    
    private let session = URLSession.shared
    var restaurants = [Restaurant]()
    var annotations = [MKPointAnnotation()]
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchBar: UITextField!
    
   
    @IBAction func search(_ sender: Any) {
        
        
        let search = searchBar.text
        if  search != "" {
            getRestaurant(search: search!)
            
       
        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        let initialLocation = CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var region = MKCoordinateRegion(center: initialLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        
        var location = CLLocationCoordinate2D()
        
        if restaurants.isEmpty == false{
            for restaurant in restaurants{
                 location = CLLocationCoordinate2D(latitude: restaurant.latitude,
                                                      longitude: restaurant.longitude)
                
                region = MKCoordinateRegion(center: location, span: span)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = restaurant.name
                annotations += [annotation]
            }
            mapView.setRegion(region, animated: true)
            mapView.showAnnotations(annotations, animated: true)
        }

        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    private func getRestaurant(search: String) {
        
        
        let base_url:String = "https://api.yelp.com/v3/businesses/search?location=\(search)&locale=en_AU"
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
                    self.annotations.removeAll()
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

                    }
                }
                else{
                    self.restaurants.append(Restaurant(photo: UIImage(named:""), name: "No Data", type: "Type", distance: 1, cost: "", rating: 0, latitude: 0, longitude: 0, phone: "",  address: ""))
                }
                DispatchQueue.main.async {
                    // Update UI
                    self.viewWillAppear(true)
                }
                
//                DispatchQueue.main.async(execute:{
//                    self.delegate?.updateUI()
//                })
                
                
            }
            
        })
        task.resume()
        
    }

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */




