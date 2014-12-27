//
//  Register.swift
//  LoginWithDatabase
//
//  Created by Márk Repits on 2014.12.19..
//  Copyright (c) 2014 Márk Repits. All rights reserved.
//

import UIKit

class Register: UIViewController {
    
    @IBOutlet var username:UITextField!
    @IBOutlet var password:UITextField!
    @IBOutlet var passAgain:UITextField!
    @IBOutlet var email:UITextField!
    @IBOutlet var regButton:UIButton!
    @IBOutlet var cancelButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDesign()
        // Do any additional setup after loading the view.
    }
    func loadDesign(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        self.username.layer.borderColor = UIColor.whiteColor().CGColor
        self.username.layer.borderWidth = 1.0
        self.username.borderStyle = UITextBorderStyle.None
        self.username.layer.cornerRadius = 7.0
        self.username.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.username.textColor = UIColor.whiteColor()
        
        self.password.layer.borderColor = UIColor.whiteColor().CGColor
        self.password.layer.borderWidth = 1.0
        self.password.borderStyle = UITextBorderStyle.None
        self.password.layer.cornerRadius = 7.0
        self.password.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.password.textColor = UIColor.whiteColor()
        
        self.passAgain.layer.borderColor = UIColor.whiteColor().CGColor
        self.passAgain.layer.borderWidth = 1.0
        self.passAgain.borderStyle = UITextBorderStyle.None
        self.passAgain.layer.cornerRadius = 7.0
        self.passAgain.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.passAgain.textColor = UIColor.whiteColor()
        
        self.email.layer.borderColor = UIColor.whiteColor().CGColor
        self.email.layer.borderWidth = 1.0
        self.email.borderStyle = UITextBorderStyle.None
        self.email.layer.cornerRadius = 7.0
        self.email.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        
        self.regButton.layer.borderWidth = 1.0
        self.regButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.regButton.layer.cornerRadius = 7.0
        self.regButton.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        
        self.cancelButton.layer.borderWidth = 1.0
        self.cancelButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.cancelButton.layer.cornerRadius = 7.0
        self.cancelButton.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(){
        let alert:UIAlertView = UIAlertView(title: "Figyelmeztetés", message: "Ez a funkció jelenleg nem elérhető kérlek próbáld később", delegate: self, cancelButtonTitle: "Rendben")
        alert.show()
        self.reg()
    }
    @IBAction func cancel(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func reg(){
        if  self.username.text != "" && self.password.text != "" && self.email.text != "" && self.passAgain.text != "" && self.password.text == self.passAgain.text {
            let alert:UIAlertView = UIAlertView(title: "Minden OK", message: "Minden mező rendben volt indul a regisztráció", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
