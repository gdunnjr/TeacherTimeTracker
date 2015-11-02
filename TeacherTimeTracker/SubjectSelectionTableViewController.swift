//
//  SubjectSelectionTableViewController.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/12/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import UIKit
import Parse

class SubjectSelectionTableViewController: UITableViewController {
    var subjects:[String]!
    var selectedSubject:String? = nil
    var selectedSubjectIndex:Int? = nil
    var subjectArray:NSMutableArray = []
    var selectedSubjectObject:PFObject! = nil
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    var indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //subjects = ["English","Math","Science","Social Studies"]
        loadSubjectArray()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return subjectArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SubjectCell", forIndexPath: indexPath) as UITableViewCell
        //cell.textLabel?.text = subjects[indexPath.row]
        //var subjectObject = subjectArray[indexPath.row] as PFObject
        if let subjectObject = subjectArray[indexPath.row] as? PFObject {
            cell.textLabel?.text = getSubjectName(subjectObject)
        }
        
        if indexPath.row == selectedSubjectIndex {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedSubjectIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedSubjectIndex = indexPath.row
        if let subjectObject = subjectArray[indexPath.row] as? PFObject {
            selectedSubject = getSubjectName(subjectObject)
        }
        
      //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedSubject" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                selectedSubjectIndex = indexPath?.row
                if let index = selectedSubjectIndex {
                    //selectedSubject = subjects[index]
                    
                   // var subjectObject = subjectArray[index] as PFObject
                    if let mySubjectObject = subjectArray[index] as? PFObject {
                        selectedSubject = getSubjectName(mySubjectObject)
                        selectedSubjectObject = mySubjectObject
                    }
                    
                }
            }
        }
    }
    
    func loadSubjectArray(){

        indicator.color = UIColor .blackColor()
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubviewToFront(self.view)
        indicator.startAnimating()
        
        //var query : PFQuery = PFUser.query()
        var query = PFQuery(className: "Subject")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    var mySubject = object as PFObject
                    //println( object)
                    println( mySubject)
                    
                    if let serviceTypeUnwrap = mySubject["subjecttName"] as? String {
                        let mySubjectName = mySubject["subjecttName"] as String
                        println(mySubjectName)
                    }
                    self.subjectArray.addObject(mySubject)
                }
                self.tableView.reloadData()
                self.indicator.stopAnimating()

            } else {
               self.indicator.stopAnimating()
                
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
      /*
        query.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]!, error:NSError!) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        //self.subjectArray.addObject(object)
                    }
                }
            } else {
                println("There was an error")
            }
        }
*/
    }
    
    func getSubjectName(subjectObject: PFObject) -> String {
        var subjectName = ""
        if let tmpSubjectName = subjectObject["subjectName"] as? String {
            subjectName = tmpSubjectName
        }
        return subjectName
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
