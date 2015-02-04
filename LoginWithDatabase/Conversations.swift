//
//  Conversations.swift
//  LoginWithDatabase
//
//  Created by Márk Repits on 2014.12.04..
//  Copyright (c) 2014 Márk Repits. All rights reserved.
//

import UIKit

class Conversations: UITableViewController {
    
    var user_id:String!
    var convs:NSArray!
    var succes:NSMutableArray!
    var userName:String!
    var newConvView:UIView!
    
    @IBAction func logOut(){
        var main:ViewController = storyboard?.instantiateViewControllerWithIdentifier("loginView") as ViewController!
        self.presentViewController(main, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDesign()
        self.getData()
    }
    func loadDesign(){
        self.tableView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        self.tableView.rowHeight = 50
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 38.0/255.0, green: 166.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
        self.navigationItem.title = "iMessenger"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.tableView.rowHeight = 70
        //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 20)]
        //self.navigationController?.navigationBar.titleTextAttributes = [UIFont.self: UIFont(name: "Helverica, Light", size: 20)]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.succes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as Cell
        var item:NSDictionary = succes[indexPath.row] as NSDictionary
        cell.userLabel.text = ((getuser_id((item.valueForKey("user_one_id") as? String)!))+" -> "+(getuser_id((item.valueForKey("user_two_id") as? String)!))) as String
        //cell.label.text = "\(indexPath.row)"
        
        //design
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        cell.userLabel.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    func getuser_id( usrid:String) -> String{
        
        var username:String = ""
        var str1:String = "http://users.ininet.hu/repimark/Messenger/getUsername.php?user_id="+usrid;
        var url1:NSURL = NSURL(string: str1)!
        var data1:NSData = NSData(contentsOfURL: url1)!
        var err:NSError?
        let parsedObject2:NSMutableArray = NSJSONSerialization.JSONObjectWithData(data1, options:NSJSONReadingOptions.AllowFragments, error:&err) as NSMutableArray!
       
        if let result:NSDictionary = parsedObject2[0] as? NSDictionary{
            username = result.valueForKey("username") as String
        }
        return username
    }
    
    func getData(){
        var str:String = "http://users.ininet.hu/repimark/Messenger/getConversations.php?user_id="+user_id;
        var url:NSURL = NSURL(string: str)!
        var data:NSData = NSData(contentsOfURL: url)!
        succes = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:nil) as NSMutableArray
        
    }
    
    @IBAction func newConvButton(){
        let navbarHeight = self.navigationController?.navigationBar.bounds.height
        newConvView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 800))
        let friend = UILabel(frame: CGRectMake(0, 10, self.view.bounds.width, 100))
        let Picker = UIPickerView(frame: CGRectMake(0, 100, self.view.bounds.width, 300))
        let newButton = UIButton(frame: CGRectMake(0, self.view.bounds.height - CGFloat(navbarHeight!) - 100, self.view.bounds.width / 2, 80))
        let cancelButton = UIButton(frame: CGRectMake(self.view.bounds.width / 2, self.view.bounds.height - CGFloat(navbarHeight!) - 100  , self.view.bounds.width / 2 , 80))
        newButton.addTarget(self, action: Selector("newConversation"), forControlEvents: UIControlEvents.TouchUpInside)
        friend.text = "Ismerős Kiválasztása"
        friend.tintColor = UIColor.whiteColor()
        newButton.setTitle("Kiválaszt", forState: .Normal)
        cancelButton.addTarget(self, action: Selector("dismissView"), forControlEvents: .TouchUpInside)
        cancelButton.setTitle("Mégsem", forState: .Normal)
        // 192, 57, 43 red colors
        // green colors 38, 166, 9
        cancelButton.backgroundColor = UIColor(red: 192.0/255.0, green: 57.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        newButton.backgroundColor = UIColor(red: 38.0/255.0, green: 166.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        newConvView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(1.0)
        self.newConvView.addSubview(friend)
        self.newConvView.addSubview(Picker)
        self.newConvView.addSubview(newButton)
        self.newConvView.addSubview(cancelButton)
        
        self.view.addSubview(newConvView)
    }
    func dismissView(){
        self.newConvView.removeFromSuperview()
    }
    
    func newConversation(){
        let urlStr = "http://users.ininet.hu/repimark/Messenger/newConversation.php"
        let request = NSMutableURLRequest(URL: NSURL(string: urlStr)!)
        request.HTTPMethod = "POST"
        let postString: String!//= "user_one_id="+user_one+"&user_two_id="+user_2;
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil
            {
                println("A hiba : \(error)")
                return
            }
            //if HTTPResponse.statusCode == 200
            
            //let jsonError:NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSMutableArray!
            
            //self.succes = jsonResult.count
            //println("\(self.succes)")
        })
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            var vc:SelectedConverstion = segue.destinationViewController as SelectedConverstion
            var ipr:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            var item:NSDictionary = succes[ipr.row] as NSDictionary
            vc.convId = (item.valueForKey("c_id") as? String)!
            vc.user_two = (item.valueForKey("user_two_id") as? String)!
            vc.user_one = (item.valueForKey("user_one_id") as? String)!
            vc.user_id = user_id!
    }


   }
