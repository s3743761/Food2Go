//
//  favouriteTableViewController.swift
//  Food2Go
//
//  Created by Liam Hector on 24/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit
import os.log

public class favouriteTableViewController: UITableViewController {
    //Mark Properties
    var favourites = [Favourites]()
    let testVC = RestaurantViewController()
    let fav = [Favourites]()
    var savedArray = [String]()
    var loadarray = [String]()
    var defaults = UserDefaults.standard
    
  
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        //loadSampleFavourites()

        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSampleFavourites()
        self.tableView.reloadData()
    }
    
    @objc func refresh(sender:AnyObject) {
        loadSampleFavourites()
        self.tableView.reloadData()
       
        self.refreshControl!.endRefreshing()
    }
    
    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favourites.count
    }

    //SHowing all favourites data
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "favouriteTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? favouriteTableViewCell  else {
            fatalError("The dequeued cell is not an instance of favouriteTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let favourite = favourites[indexPath.row]
        
        cell.restaurantName.text = favourite.name
        cell.restaurantRating.text = favourite.rating
       


        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
 /*
 Prepare cells  for favoouriite table view according to the number of restaurants.
 
*/
    //individual favourite views
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            

            
        case "ShowFavourite":
            guard let favouriteDetailViewController = segue.destination as? favouritesViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedFavouriteCell = sender as? favouriteTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedFavouriteCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedFavourite = favourites[indexPath.row]
            favouriteDetailViewController.favourite = selectedFavourite
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }
    

    //deleting favourites
    override public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print(favourites)
            favourites.remove(at: indexPath.row)
            testVC.deleteElement(forRowAt: indexPath)
            print(favourites)
            
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
    }

    

    
 /*
     
 Calls the function in retaurant view controller class which returns array that stores the fav resturants upon clicking the button.Saves the resturant name locally and Loads favourites when the user redirects to favourite tab.
 
 */
    
     public func loadSampleFavourites(){
     
        
        let favResturant = testVC.myArrayFunc(inputArray: fav)
        
        
        
        
        favourites = favResturant
        
        var currentIndex = 0
        
        for rest in favourites
        {
            savedArray += [rest.name]
            
            currentIndex += 1
        }
        
        defaults.set(savedArray, forKey: "SavedStringArray")
        loadarray = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()
      
        
    }

    
   public func returnLoad(inputArray:Array<String>) -> Array<String> {
        let copiedArray = savedArray
        
     
        return copiedArray
       
        
    }
    
    
    
}
