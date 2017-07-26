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
        geoCoder.reverseGeocodeLocation(currentLocation!, completionHandler: { (placemarks, error) -> Void in
            if (placemarks?.count)! > 0 && self.isFinished == false
            {
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                if let name = placeMark.addressDictionary!["SubAdministrativeArea"] as? String {
                    self.location = self.location + name + ","
                }
                if let street = placeMark.addressDictionary!["SubLocality"] as? String {
                    self.location = self.location + street + ","
                
                }
                if let city = placeMark.addressDictionary!["City"] as? String {
                    self.location += city
                }
                let userID = FIRAuth.auth()?.currentUser?.uid
                let email = FIRAuth.auth()?.currentUser?.email
                let date = Date()
                print(date.millisecondsSince1970)
                self.ref.child("users").child(userID!).setValue(["location": self.location,"email":email,"longitude": currentLocation?.coordinate.longitude,"latitude":currentLocation?.coordinate.latitude,"time": date.millisecondsSince1970])
                //print(self.location)
                self.isFinished = true
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Map Feed"
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(hex: "69C49C")
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
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
