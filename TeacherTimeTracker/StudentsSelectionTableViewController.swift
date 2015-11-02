//
//  StudentsSelectionTableViewController.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 9/8/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import UIKit
import Parse

class StudentsSelectionTableViewController: UITableViewController {
    var students:[String]!
    var selectedStudent:String? = nil
    var selectedStudentIndex:Int? = nil
    var studentArray:NSMutableArray = []
    var selectedStudents:[String] = []
    
   // var selectedStudentArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //selectedStudents.append("Y")
        loadStudentArray()
        
        // Do while all selected rows are deleted
        
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
        return studentArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentCell", forIndexPath: indexPath) as UITableViewCell
        
        if let studentObject = studentArray[indexPath.row] as? PFObject {
            cell.textLabel?.text = getStudentName(studentObject)
        }
        
        if selectedStudents[indexPath.row]=="Y" {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        //selectedStudentIndex = indexPath.row
        //if let studentObject = studentArray[indexPath.row] as? PFObject {
        //    selectedStudent = getStudentName(studentObject)
        //}
        
        selectedStudents[indexPath.row] = "Y"
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        
        println(cell?.detailTextLabel)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveSelectedStudents" {
            selectedStudent = ""
            //if let indexPaths = tableView.indexPathsForSelectedRows() {
                // Do while all selected rows are deleted
            for (var i = 0; i < tableView.numberOfRowsInSection(0); i++) {
                    if selectedStudents[i]=="Y" {
                    if let studentObject = studentArray[i] as? PFObject {
                        if (selectedStudent != "") {
                            selectedStudent = selectedStudent! + ", " + getStudentName(studentObject)
                        } else {
                            selectedStudent = getStudentName(studentObject)
                        }
                    }
                }
                
            }
            
        }
    }
    
    func getStudentName(studentObject: PFObject) -> String {
        var studentName = ""
        if let tmpStudentName = studentObject["studentName"] as? String {
            studentName = tmpStudentName
        }
        return studentName
    }
    
    func loadStudentArray(){
        //var query : PFQuery = PFUser.query()
        var query = PFQuery(className: "Student")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    var myStudent = object as PFObject
                    //println( object)
                    println( myStudent)
                    
                    if let serviceTypeUnwrap = myStudent["studentName"] as? String {
                        let myStudentName = myStudent["studentName"] as String
                        println(myStudentName)
                    }
                    self.studentArray.addObject(myStudent)
                    self.selectedStudents.append("N")
                    println(self.selectedStudents.count)
                }
                
                self.tableView.reloadData()
            } else {
                
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
