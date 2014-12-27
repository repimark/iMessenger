//
//  ViewController.swift
//  LoginWithDatabase
//
//  Created by Márk Repits on 2014.12.03..
//  Copyright (c) 2014 Márk Repits. All rights reserved.
//  http://users.ininet.hu/repimark/Messenger/getConversations.php?user_id=1
//  http://users.ininet.hu/repimark/Messenger/convDetail.php?c_id=1

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var succes:Int!
    
    @IBOutlet var userName:UITextField!
    
    @IBOutlet var passWord:UITextField!
    
    @IBOutlet var reg:UIButton!
    
    @IBOutlet var login:UIButton!
    
    var user_id:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDesign()
        self.userName.delegate = self
        self.passWord.delegate = self
    }
    
    func setDesign(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        self.passWord.textColor = UIColor.whiteColor()
        self.userName.layer.borderColor = UIColor.whiteColor().CGColor
        self.userName.layer.cornerRadius = 7.0
        self.userName.layer.borderWidth = 1.0
        self.userName.borderStyle = UITextBorderStyle.None
        self.passWord.layer.borderWidth = 1.0
        self.passWord.layer.borderColor = UIColor.whiteColor().CGColor
        self.passWord.layer.cornerRadius = 7.0
        self.passWord.borderStyle = UITextBorderStyle.None
        self.login.layer.borderColor = UIColor.whiteColor().CGColor
        self.login.layer.borderWidth = 1.0
        self.login.layer.cornerRadius = 7.0
        self.reg.layer.borderWidth = 1.0
        self.reg.layer.borderColor = UIColor.whiteColor().CGColor
        self.reg.layer.cornerRadius = 7.0
        self.reg.enabled = true
        self.login.enabled = true
        self.login.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.login.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        self.reg.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.reg.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        self.reg.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.login.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.userName.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.passWord.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logonBtn(){
        Login(userName.text, password: passWord.text)
        //println(succes)
        if succes == 1 {
            // átirányítás
            var VC1 = self.storyboard?.instantiateViewControllerWithIdentifier("Cnv") as Conversations
            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
            VC1.userName = userName.text
            VC1.user_id = user_id
            self.presentViewController(navController, animated:true, completion: nil)

            
        }else{
            let loginAlert:UIAlertView = UIAlertView(title: "Sikertelen Bejelentkezés", message: "Rossz felhasználónév vagy/és jelszó", delegate: self, cancelButtonTitle: "Rendben")
            loginAlert.show()
        }
        
    }
    func Login(username:String, password:String ){
        var str = "http://users.ininet.hu/repimark/Messenger/login.php?username="+username+"&password="+password;
        var url:NSURL = NSURL(string: str)!
        var data:NSData = NSData(contentsOfURL: url)!
        //succes = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)! as NSMutableArray
        var error:NSError?
        let parsedObject: NSMutableArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&error) as NSMutableArray!
        if error == nil {
            if parsedObject.count == 1{
                let result:NSDictionary = parsedObject[0] as NSDictionary
                succes = 1
                user_id = result.valueForKey("user_id") as String
            }else{
                println("Sikertelen")
            }
        }else{
            println("Sikertelen")
        }
        
    }
    @IBAction func register(){
        let alert:UIAlertView = UIAlertView(title: "Figyelmeztetés", message: "Ez a funkció még nem elérhető !", delegate: self, cancelButtonTitle: "Értem")
        //alert.show()
        var registerView:Register = storyboard?.instantiateViewControllerWithIdentifier("regView") as Register
        self.presentViewController(registerView, animated: true, completion: nil)
    }
    
    
    


}

