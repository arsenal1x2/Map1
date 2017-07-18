//
//  SignupViewController.swift
//  Map
//
//  Created by may985 on 7/11/17.
//  Copyright © 2017 may985. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var textFieldPassword: UITextField!
    var listCountryPicker:[Country] = [Country]()
    @IBOutlet weak var dateTime: UIDatePicker!
    @IBOutlet weak var buttonSignup: UIButton!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var buttonChooseCountry: UIButton!
    @IBOutlet weak var buttonChooseYourBirthday: UIButton!
    @IBOutlet weak var buttonFemale: UIButton!
    @IBOutlet weak var buttonMale: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    var headPhoneNumberPicker:UIPickerView = UIPickerView()
    override func viewDidLoad() {
         initView()
        headPhoneNumberPicker.dataSource = self
        headPhoneNumberPicker.delegate = self
        loadData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signup(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func chooseHeadPhoneNumberCountry(_ sender: Any) {
        if(dateTime.isHidden == false){
       
          setView(view: dateTime, hidden: true)
        }
        setView(view: headPhoneNumberPicker, hidden: false)
    }
    @IBAction func pickDate(_ sender: Any) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
      //  initView()
        headPhoneNumberPicker.isHidden = true
        let tab: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.end))
        //view.addSubview(tab)
        view.addGestureRecognizer(tab)
        //initView()
        navigationController?.navigationBar.isHidden = false
        buttonSignup.layer.cornerRadius = 4
        navigationController?.navigationBar.barTintColor = UIColor(hex: "69C49C")
        buttonFemale.layer.borderWidth = 1
        buttonFemale.layer.borderColor = UIColor(hex: "69C49C").cgColor
        buttonMale.layer.cornerRadius = 5
        buttonMale.layer.borderWidth = 1
        buttonMale.layer.borderColor = UIColor(hex: "69C49C").cgColor
        buttonFemale.layer.cornerRadius = 5
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "password",
                                                                     attributes: [NSForegroundColorAttributeName: UIColor(hex: "69C49C")])
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "email",
                                                                  attributes: [NSForegroundColorAttributeName: UIColor(hex: "69C49C")])
        textFieldPhoneNumber.attributedPlaceholder = NSAttributedString(string: "phone number",
                                                                        attributes: [NSForegroundColorAttributeName: UIColor(hex: "69C49C")])
        
    }
    
    @IBAction func clickMale(_ sender: Any) {
        buttonFemale.backgroundColor = UIColor.white
        buttonFemale.setTitleColor(UIColor(hex: "69C49C"), for: .normal)
        buttonMale.backgroundColor = UIColor(hex: "69C49C")
        buttonMale.setTitleColor(UIColor.white, for: .normal)
    }

    @IBAction func clickFemale(_ sender: Any) {
        buttonMale.backgroundColor = UIColor.white
        buttonMale.setTitleColor(UIColor(hex: "69C49C"), for: .normal)
        buttonFemale.backgroundColor = UIColor(hex: "69C49C")
        buttonFemale.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func chooseYourBirthday(_ sender: Any) {
        if(headPhoneNumberPicker.isHidden == false){
            setView(view: headPhoneNumberPicker, hidden: true)

        }
        setView(view: dateTime, hidden: false)
        
    }
}
extension SignupViewController{
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { _ in
            view.isHidden = hidden
        }, completion: nil)
    }
    func end(sender: UITapGestureRecognizer){
        if(dateTime.isHidden == false){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let strDate = dateFormatter.string(from: dateTime.date)
            self.buttonChooseYourBirthday.setTitle(strDate, for: .normal)
            setView(view: dateTime, hidden: true)
        }
        if(headPhoneNumberPicker.isHidden == false){
          
          setView(view: headPhoneNumberPicker, hidden: true)
            
        }
        view.endEditing(true)
    }
    func loadData(){
        do {
            if let file = Bundle.main.url(forResource: "CountryCodes", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let listCountry = json as? [[String:Any]] {
                    for countryObject in listCountry{
                        if let code = countryObject["code"] as? String{
                            if let dialCode = countryObject["dial_code"] as? String{
                                if let name = countryObject["name"] as?String{
                                   let country = Country(code: code, dialCode: dialCode, name: name)
                                    self.listCountryPicker.append(country)
                                }
                            }
                        }
                    }
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    func initView(){
        createHeadPhoneNumberPicker()
    }
    func createHeadPhoneNumberPicker(){
        headPhoneNumberPicker = UIPickerView()
        headPhoneNumberPicker.translatesAutoresizingMaskIntoConstraints = false
        headPhoneNumberPicker.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.addSubview(headPhoneNumberPicker)
        let leadingContraint = NSLayoutConstraint(item: headPhoneNumberPicker, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingContraint = NSLayoutConstraint(item: headPhoneNumberPicker, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let bottomContraint = NSLayoutConstraint(item: headPhoneNumberPicker, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let heightContraint = NSLayoutConstraint(item: headPhoneNumberPicker, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200)
        view.addConstraints([leadingContraint,trailingContraint,bottomContraint,heightContraint])
    }
}
extension SignupViewController{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listCountryPicker.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = listCountryPicker[row].name
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 17.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.buttonChooseCountry.setTitle("("+listCountryPicker[row].dialCode+")", for: .normal)
    }
}
