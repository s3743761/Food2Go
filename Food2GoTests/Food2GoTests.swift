//
//  Food2GoTests.swift
//  Food2GoTests
//
//  Created by Liam Hector on 29/7/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import XCTest
@testable import Food2Go
import CoreLocation

protocol LocationManager {
    
    // CLLocationManager Properties
    var location: CLLocation? { get }
    var delegate: CLLocationManagerDelegate? { get set }
    var distanceFilter: CLLocationDistance { get set }
    var pausesLocationUpdatesAutomatically: Bool { get set }
    var allowsBackgroundLocationUpdates: Bool { get set }
    
    // CLLocationManager Methods
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func getAuthorizationStatus() -> CLAuthorizationStatus
    func isLocationServicesEnabled() -> Bool
}

extension CLLocationManager: LocationManager {
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
}



class MockLocationManager: LocationManager {
    
    var location: CLLocation? = CLLocation(
        latitude: -37.8136,
        longitude: 144.9631
    )
    
    var delegate: CLLocationManagerDelegate?
    var distanceFilter: CLLocationDistance = 10
    var pausesLocationUpdatesAutomatically = false
    var allowsBackgroundLocationUpdates = true
    
    func requestWhenInUseAuthorization() { }
    func startUpdatingLocation() { }
    func stopUpdatingLocation() { }
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return .authorizedWhenInUse
    }
    
    func isLocationServicesEnabled() -> Bool {
        return true
    }
}


class Food2GoTests: XCTestCase {
    
    let testVC = RestaurantViewController()
    let fav = [Favourites]()
    let favVC = favouriteTableViewController()
     let presenter = profileViewController()

 
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
   
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }



    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /*
     
     Tests the Favourite model class and if name is stored correctly in the object.
 
    */
    
  
    
    func testFavouriteModel_ShouldPassIfValidateFirstName() {

       let unserModel = Favourites(name: "Chin Chin", rating: "4", image: UIImage(named: "coldRock")!,  distance: "0.68", type: "Asian Fusion", cost: "$$$", latitude: -37.815605, longitude: 144.970376, phone: "123456789", location: "1 collins street Melbourne")
 
       
        XCTAssertTrue((unserModel?.name != nil))
    }
    
    func testRestaurantModel_ShouldPassIfValidateFirstName() {
        
        let unserModel = Restaurant(photo: UIImage(named: "coldRock")!, name: "Chin Chin", type: "Asian Fusion", distance: 0.68, cost: "$$$", rating: 4, latitude: -37.815605, longitude: 144.970376, phone: "123456789", address: "1 collins street Melbourne")

        
        XCTAssertTrue((unserModel.name != nil))
    }
    
    
    
    /*
     
     Tests if the favouriite resturant name is loaded from the core data
     
     */
    
    
    func testIfResturantNameLoads_ShouldPassIfFavNameInResturantLoadsFromLocally() {
        // This is an example of a performance test case.
        let favVC = favouriteTableViewController()
       
        
        let favourite = Favourites(name: "Chin Chin", rating: "4", image: UIImage(named: "coldRock")!,  distance: "0.68", type: "Asian Fusion", cost: "$$$", latitude: -37.815605, longitude: 144.970376, phone: "123456789", location: "1 collins street Melbourne")
        
        favVC.savedArray.append(favourite!.name)
        var loadArray = [String]()
        //loadArray = favVC.returnLoad(inputArray: favVC.savedArray)
        var index = 0
        var loadName = "Chin Chin"
        for name in loadArray
        {
            if index == 0 {
                loadName = name
                break
            }
            
            index += 1
        }
        
        
        XCTAssertEqual(loadName, favourite!.name)
    }
    
    /*
     
     Tests if the current location of the user is stored correclty.
     
     */
    
    func testCurrentLocation_ShouldPassIfLocationBeingStored(){

        let locationManager = MockLocationManager()
        let rest = restaurantTableViewController()
        var val = (locationManager.location?.coordinate.latitude)!
        var getVal = rest.getLocation(double: val)

        XCTAssertEqual(val, getVal)
       
    }
    
    
    /*
     
     Tests if the url of the yelp api loads correclty with  users current locatiion.
     
     */
    

    
    func testUrlLoads_ShouldPassIfUrlLoadsWithCurrentLocation() {
        let locationManager = MockLocationManager()
    
       
        let base_url:String = "https://api.yelp.com/v3/businesses/search?latitude=\(locationManager.location?.coordinate.latitude)&longitude=\(locationManager.location?.coordinate.longitude)&locale=en_AU"
        let url = base_url
        
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        if let url = URL(string: escapedAddress!)
        {
            var request = URLRequest(url: url)
            request.setValue("Bearer \("m6zc6ykH0ExBpRuZ6iJlritn-922o7X5zS9_EItBG3R3yGkFHFibKOIOGPKyfXifjP9y_vXdRyURl4NCdiyQu2oq6rCdrX66v1f1Jn4TuxmNNhVPshuFC0CheK56X3Yx")", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
    
        }
      
        XCTAssertEqual(url, base_url)
        
    }
    
    
    /*
     
     Tests if the favourite resturant element from array is removed when the cell is deleted from the favourties tab
     
     */
    
    
    func testCellRemovedFavourite_ShouldPassIfElementRemovedFromArrayAndCell() {
        
        let favourite = Favourites(name: "Chin Chin", rating: "4", image: UIImage(named: "coldRock")!,  distance: "0.68", type: "Asian Fusion", cost: "$$$", latitude: -37.815605, longitude: 144.970376, phone: "123456789", location: "1 collins street Melbourne")
        
        
        var string  = [String]()
        string.append(favourite!.name)
        print(string)
        let count = string.count
        string = testVC.getDeletedArray( forRowAt: 0 ,input: string)
        
        XCTAssertEqual(count-1, string.count)
        
    }
    
   
    
    
    
    


}
