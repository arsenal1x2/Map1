//
//  LoginViewController.swift
//  Map
//
//  Created by may985 on 7/11/17.
//  Copyright © 2017 may985. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func login(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "listUser")
        self.present(vc!,animated: true)
    }
    @IBOutlet weak var buttonLogin: UIButton!
    @IBAction func handleForgotPassword(_ sender: Any) {
    }
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(hex: "69C49C")
        buttonLogin.layer.cornerRadius = 4
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "email",
                                                               attributes: [NSForegroundColorAttributeName: UIColor(hex: "69C49C")])
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "password",
                                                                  attributes: [NSForegroundColorAttributeName: UIColor(hex: "69C49C")])
        
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
