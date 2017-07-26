//
//  SettingsViewController.swift
//  Map
//
//  Created by may985 on 7/13/17.
//  Copyright © 2017 may985. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseAuth
class SettingsViewController: UITableViewController {
    @IBOutlet weak var buttonMenu: UIBarButtonItem!

    override func viewDidLoad() {
        if revealViewController() != nil {
            buttonMenu.target = revealViewController()
            buttonMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            navigationController?.navigationBar.isHidden = false
            navigationController?.navigationBar.barTintColor = UIColor(hex: "69C49C")

        }

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertSignoutController:UIAlertController = UIAlertController(title: "Are you sure you want to signout", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
           self.dismiss(animated: true, completion: nil)
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertSignoutController.addAction(okAction)
        alertSignoutController.addAction(cancelAction)
        self.present(alertSignoutController, animated: true, completion: nil)
    }

   

}
