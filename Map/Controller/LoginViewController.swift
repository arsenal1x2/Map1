//
//  LoginViewController.swift
//  Map
//
//  Created by may985 on 7/11/17.
//  Copyright © 2017 may985. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase
class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBAction func login(_ sender: Any) {
        guard let email = textFieldEmail?.text else{
           return
        }
        guard let password = textFieldPassword?.text else{
           return
        }
        //Login
        FIRAuth.auth()?.signIn(withEmail: email, password: password) {
            (user, error) in
            if let user = FIRAuth.auth()?.currentUser {
                if !user.isEmailVerified{
                    let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email).", preferredStyle: .alert)
                    let alertActionOkay = UIAlertAction(title: "Ok", style: .default) {
                        (_) in
                        user.sendEmailVerification(completion: nil)
                    }
                    let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                    
                    alertVC.addAction(alertActionOkay)
                    alertVC.addAction(alertActionCancel)
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "listUser")
                    self.present(vc!,animated: true)
                }
            }
        }

       

        
    }
    @IBOutlet weak var buttonLogin: UIButton!
    @IBAction func handleForgotPassword(_ sender: Any) {
        let ac = UIAlertController(title: "Enter your email address to reset password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {
            void in
           let emailReset = ac.textFields?[0].text
            FIRAuth.auth()?.sendPasswordReset(withEmail: emailReset!) { error in
                // Your code here
            }
        })
        ac.addAction(cancelAction)
        ac.addAction(okAction)
        
        present(ac, animated: true)
    }
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    override func viewDidLoad() {
        textFieldPassword.delegate = self
        textFieldEmail.delegate = self
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
