//
//  ChatViewController.swift
//  Map
//
//  Created by may985 on 7/13/17.
//  Copyright © 2017 may985. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    @IBOutlet weak var buttonAddFriend: UIBarButtonItem!

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
