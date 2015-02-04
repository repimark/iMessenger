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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        //self.username.layer.borderColor = UIColor.whiteColor().CGColor
        //self.username.layer.borderWidth = 1.0
        self.username.borderStyle = UITextBorderStyle.None
        //self.username.layer.cornerRadius = 7.0
        //self.username.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.username.textColor = UIColor.whiteColor()
        
        //self.password.layer.borderColor = UIColor.whiteColor().CGColor
        //self.password.layer.borderWidth = 1.0
        self.password.borderStyle = UITextBorderStyle.None
        //self.password.layer.cornerRadius = 7.0
        //self.password.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.password.textColor = UIColor.whiteColor()
        
        //self.passAgain.layer.borderColor = UIColor.whiteColor().CGColor
        //self.passAgain.layer.borderWidth = 1.0
        self.passAgain.borderStyle = UITextBorderStyle.None
        //self.passAgain.layer.cornerRadius = 7.0
        //self.passAgain.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        self.passAgain.textColor = UIColor.whiteColor()
        
        //self.email.layer.borderColor = UIColor.whiteColor().CGColor
        //self.email.layer.borderWidth = 1.0
        self.email.borderStyle = UITextBorderStyle.None
        //self.email.layer.cornerRadius = 7.0
        self.email.textColor = UIColor.whiteColor()
        
        //self.regButton.layer.borderWidth = 1.0
        //self.regButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.regButton.layer.cornerRadius = 7.0
        self.regButton.backgroundColor = UIColor(red: 38.0/255.0, green: 166.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        
        //self.cancelButton.layer.borderWidth = 1.0
        //self.cancelButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.cancelButton.layer.cornerRadius = 7.0
        self.cancelButton.backgroundColor = UIColor(red: 192.0/255.0, green: 57.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        
        var UsernameBorder = CALayer()
        var passwordBorder = CALayer()
        var passAgainBorder = CALayer()
        var emailBorder = CALayer()
        
        UsernameBorder.borderColor = UIColor.whiteColor().CGColor
        passwordBorder.borderColor = UIColor.whiteColor().CGColor
        passAgainBorder.borderColor = UIColor.whiteColor().CGColor
        emailBorder.borderColor = UIColor.whiteColor().CGColor
        
        UsernameBorder.frame = CGRect(x: 0, y: username.frame.size.height - 1.0, width:  username.frame.size.width, height: username.frame.size.height)
        
        passwordBorder.frame = CGRect(x: 0, y: password.frame.size.height - 1.0, width:  password.frame.size.width, height: password.frame.size.height)
        
        passAgainBorder.frame = CGRect(x: 0, y: passAgain.frame.size.height - 1.0, width: passAgain.frame.size.width, height: passAgain.frame.size.height)
        
        emailBorder.frame = CGRect(x: 0, y: email.frame.size.height - 1.0, width: email.frame.size.width, height: email.frame.size.height)
        
        UsernameBorder.borderWidth = 1.0
        passwordBorder.borderWidth = 1.0
        passAgainBorder.borderWidth = 1.0
        emailBorder.borderWidth = 1.0
        
        password.layer.addSublayer(passwordBorder)
        password.layer.masksToBounds = true
        let passView = UIView(frame: CGRectMake(0, 0, 30, 30))
        passView.addSubview(UIImageView(image: UIImage(named: "lock")!))
        password.leftViewMode = UITextFieldViewMode.Always
        password.leftView = passView
        
        username.layer.addSublayer(UsernameBorder)
        username.layer.masksToBounds = true
        let userView = UIView(frame: CGRectMake(0, 0, 30, 30))
        userView.addSubview(UIImageView(image: UIImage(named: "user")!))
        username.leftViewMode = UITextFieldViewMode.Always
        username.leftView = userView
        
        passAgain.layer.addSublayer(passAgainBorder)
        passAgain.layer.masksToBounds = true
        let passAgainView = UIView(frame: CGRectMake(0, 0, 30, 30))
        passAgainView.addSubview(UIImageView(image: UIImage(named: "lock")!))
        passAgain.leftViewMode = UITextFieldViewMode.Always
        passAgain.leftView = passAgainView
        
        email.layer.addSublayer(emailBorder)
        email.layer.masksToBounds = true
        let emailView = UIView(frame: CGRectMake(0, 0, 30, 30))
        emailView.addSubview(UIImageView(image: UIImage(named: "mail")!))
        email.leftViewMode = UITextFieldViewMode.Always
        email.leftView = emailView
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(){
        
        if  self.username.text != "" && self.password.text != "" && self.email.text != "" && self.passAgain.text != "" && self.password.text == self.passAgain.text {
            registerUser(self.username.text, password: self.password.text, email: self.email.text)
        }

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
    func registerUser(username: String, password:String, email:String){
        let urlStr = "http://users.ininet.hu/repimark/Messenger/register.php"
        let request = NSMutableURLRequest(URL: NSURL(string: urlStr)!)
        request.HTTPMethod = "POST"
        let postString = "username="+username+"&password="+password+"&email="+email;
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                println("A hiba : \(error)")
                return
            }
            //if HTTPResponse.statusCode == 200
            
            //let jsonError:NSError?
            //var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSMutableArray!
            
            //self.succes = jsonResult.count
            //println("\(self.succes)")
            println(response)
            let alert = UIAlertController(title: "Regisztráció", message: "Sikeres Regisztráció", preferredStyle: UIAlertControllerStyle.Alert)
            
            let OkAction = UIAlertAction(title: "Rendben", style: UIAlertActionStyle.Default, handler: { (data) -> Void in
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginView") as ViewController
                self.dismissViewControllerAnimated(true, completion: nil)
                self.presentViewController(vc, animated: true, completion: nil)
            })
            alert.addAction(OkAction)
            self.presentViewController(alert, animated: true, completion: nil)
        })
        task.resume()
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
