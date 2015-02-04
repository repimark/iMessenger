//
//  SelectedConverstion.swift
//  LoginWithDatabase
//
//  Created by Márk Repits on 2014.12.14..
//  Copyright (c) 2014 Márk Repits. All rights reserved.
//

import UIKit

class SelectedConverstion: UITableViewController, UITextFieldDelegate {

    var conversation:NSMutableArray!
    var selectedUserName:String!
    var convId:String!
    var user_one:String!
    var user_two:String!
    var user_id:String!
    
    @IBOutlet var replyText:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.tableView.separatorColor = UIColor.whiteColor()
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.rowHeight = 50
        self.replyText.delegate = self
        

    }
    @IBAction func sendButtonPressed(){
        //let replyTextString = replyText.text
        sendPostReply(replyText.text, user_id: user_one, c_id: convId)
        
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
        return conversation.count
    }
    
    func getData(){
        if convId != "" {
        var str:String = "http://users.ininet.hu/repimark/Messenger/convDetail.php?c_id="+convId;
        var url:NSURL = NSURL(string: str)!
        var data:NSData = NSData(contentsOfURL: url)!
        var errorJson:NSError?
        conversation = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error:&errorJson) as NSMutableArray
            if errorJson != nil {
                println(errorJson?.localizedDescription)
            }
        }
        
    }

//    func sendReply(reply:String , user_id:String, c_id:String){
//        let newReplyStr:String = "http://users.ininet.hu/repimark/Messenger/newReply.php?reply="+reply+"&user_id="+user_id+"&c_id="+c_id
//        let url:NSURL = NSURL(string: newReplyStr)!
//        //let data1:NSData = (newReplyStr.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true))!
//        let data:NSData = NSData(contentsOfURL: url)!
//        self.getData()
//        replyText.text = ""
//        self.tableView.reloadData()
//    }
    func sendPostReply(reply:String , user_id:String, c_id:String){
        let newReplyStr:String = "http://users.ininet.hu/repimark/Messenger/newReplyPost.php"
        let request = NSMutableURLRequest(URL: NSURL(string: newReplyStr)!)
        request.HTTPMethod = "POST"
        let postString = "reply=\(reply)&user_id=\(user_id)&c_id=\(c_id)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                println("error=\(error)")
                return
            }
            
            println("response = \(response)")
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println(responseString)
            self.getData()
            self.tableView.reloadData()
        }
        task.resume()
        replyText.text = ""
        
    }
    @IBAction func refreshConv(){
        getData()
        tableView.reloadData()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var message:NSDictionary = conversation[indexPath.row] as NSDictionary
        cell.layoutMargins = UIEdgeInsetsZero
        var sender:String = (message.valueForKey("user_id_fk")!) as String
        if sender == user_one {
            cell.textLabel?.textAlignment = NSTextAlignment.Left
            cell.backgroundColor = UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
            cell.textLabel?.backgroundColor = UIColor.clearColor()
        }else if sender == user_two{
            cell.textLabel?.textAlignment = NSTextAlignment.Right
            cell.backgroundColor = UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/255.0, alpha: 1.0)
            cell.textLabel?.backgroundColor = UIColor.clearColor()
        }
        
        cell.textLabel?.text = message.valueForKey("reply") as? String
        

        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
