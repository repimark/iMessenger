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
        self.navigationController?.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var item:NSDictionary = succes[indexPath.row] as NSDictionary
        cell.textLabel?.text = ((getuser_id((item.valueForKey("user_one_id") as? String)!))+" -> "+(getuser_id((item.valueForKey("user_two_id") as? String)!))) as String
        
        
        //design
        cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
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
