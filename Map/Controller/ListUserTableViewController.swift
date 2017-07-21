//
//  ListUserTableViewController.swift
//  Map
//
//  Created by may985 on 7/13/17.
//  Copyright © 2017 may985. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
import MapKit
class ListUserTableViewController: UITableViewController,CLLocationManagerDelegate {
  //  var ref:FIRDatabaseReference!
    var ref = FIRDatabase.database().reference()

    var locationManager:CLLocationManager = CLLocationManager()
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var location = ""
    var isFinished:Bool = false
    override func viewDidLoad() {
        
        loadLocation()
        if revealViewController() != nil {
                        menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            revealViewController().rightViewRevealWidth = 150
           
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        print(location)
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        let geoCoder = CLGeocoder()
       // var location = ""
        //let location = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
        geoCoder.reverseGeocodeLocation(currentLocation!, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            if (placemarks?.count)! > 0 && self.isFinished == false
            {
            
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
              
            // Address dictionary
                print(placeMark.addressDictionary)
                if let name = placeMark.addressDictionary!["SubAdministrativeArea"] as? String {
                    self.location = self.location + name + ","
                //print(street)
                }
                if let street = placeMark.addressDictionary!["SubLocality"] as? String {
                //print(street)
                    self.location = self.location + street + ","
                
                }
               
                if let city = placeMark.addressDictionary!["City"] as? String {
                //print(street)
                    self.location += city
                    
                }
                let userID = FIRAuth.auth()?.currentUser?.uid
                let email = FIRAuth.auth()?.currentUser?.email
                self.ref.child("users").child(userID!).setValue(["location": self.location,"email":email,"longtitude": currentLocation?.coordinate.longitude,"latitude":currentLocation?.coordinate.latitude,"time":Date().millisecondsSince1970])
                //print(self.location)
                self.isFinished = true
                
            }
          // print(location)
            
            // Location name
        })
       // print(location)
        
    }
    override func viewWillAppear(_ animated: Bool) {
                self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Map Feed"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(hex: "69C49C")
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Map") as! MapViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    

}
