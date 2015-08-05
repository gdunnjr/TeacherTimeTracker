//
//  TabBarViewController.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/3/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        var testQuery = PFQuery(className: "TestObject")
        testQuery.whereKey("foo", equalTo: "Test Me New 92")
        testQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    println(object)
                    var relation = object.relationForKey("subjectPtr")
                    
                    // code to iterate relationships
                    relation.query().findObjectsInBackgroundWithBlock {
                        (relationObjects: [AnyObject]!, error: NSError?) -> Void in
                        if let error = error {
                            // There was an error
                        } else {
                            // objects has all the Posts the current user liked.
                       
                            for relationObject in relationObjects {
                                //println(relationObject)
                                var subjectName = ""
                                if let subjectNameUnwrap = relationObject["subjectName"] as? String {
                                    subjectName = relationObject["subjectName"] as String
                                    println(subjectName)
                                }
                            }
                            
                        }
                    }
                    
                }

            } else {
            
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
    }
    

    
    
    
/*
        var subObj1 = PFObject(className:"subject")
        subObj1["subjectName"] = "Prog 900"
        subObj1.saveInBackground()
        
        var subObj2 = PFObject(className:"subject")
        subObj2["subjectName"] = "Prog 901"
        subObj2.saveInBackground()
        
        
        var testObject = PFObject(className:"TestObject")
        testObject["foo"] = "Test Me New 3"
        testObject.saveInBackground()
        
        var testQuery = PFQuery(className: "TestObject")
        testQuery.whereKey("foo", equalTo: "Test Me New 3")
        testQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                for object in objects {
                    println(object)
                
                // code to add relations
                let myPFObject = object as PFObject
                var relation = object.relationForKey("subjectPtr")
                relation.addObject(subObj1)
                relation.addObject(subObj2)
                myPFObject.saveInBackgroundWithBlock {
                        (success: Bool!, error: NSError!) -> Void in
                        if (success != nil) {
                            println("Saved")
                        } else {
                            println("%@", error)
                        }
                    }
                    
                /* myPFObject.setObject("Testing",forKey: "foo")
                 
                //myPFObject.setObject(subObj1,forKey: "subjectPtr1")
                myPFObject.setObject([subObj1, subObj2] ,forKey: "subjectPtr1")
                    myPFObject.saveInBackgroundWithBlock {
                        (success: Bool!, error: NSError!) -> Void in
                        if (success != nil) {
                            println("Saved")
                        } else {
                            println("%@", error)
                        }
                    }
                    
                    var subjectName = ""
                    if let pointer = object["subjectPtr"] as? PFObject {
                        subjectName = pointer["subjectName"] as String!
                        println(pointer)
                    }

*/
                }

                
            } else {
            
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
*/

     /*
        
        var query = PFQuery(className: "timeentry")
        query.includeKey("subjectPtr")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            
            if error == nil {
                
                // query successful - display number of rows found
                println("Successfully retrieved \(objects.count) time entries")
                
                // print name & hair color of each person found
                for object in objects {
                    
                    //let startDateTime = object["startDateTime"] as NSString
                    //var startDateTime = object["startDateTime"]
                    //if startDateTime != nil {
                    //    let dateFormatter = NSDateFormatter()
                    //    dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
                    //    let date = dateFormatter.stringFromDate(startDateTime as NSDate)
                    //    println(date)
                    //}
                    //var serviceType = ""
                    //if let serviceTypeUnwrap = object["serviceType"] as? String {
                    //    serviceType = object["serviceType"] as String
                   // }
                    
                    //var subjectName = ""
                    //if let subjectNameUnwrap = object["subjectName"] as? String {
                    //    subjectName = object["subjectName"] as String
                    //}
                    
                    
                    let notes = object["notes"] as NSString
        
                    //var subjectPtrObject =  object["subjectPtr"] //Since it automatically loaded the data inside the subclass, you don't actually have to set any variable
                    //var subjectName = ""
                    //if let subjectNameUnwrap = subjectPtrObject as? String {
                    //    subjectName = subjectPtrObject as String
                    //}
                    
                    var subjectName = ""
                    if let pointer = object["subjectPtr"] as? PFObject {
                        subjectName = pointer["subjectName"] as String!
                    }
                    
                    //let subjectName = object["subjectName"] as NSString
                    
                    
                    //println(subjectPtrObject)
                    println(subjectName)
                    println(notes)
                    
                    
  //                  println(object)
//
    //                println("subjectName = \(subjectName)")
      //              println("notes = \(notes)")
        //            println("serviceType = " + serviceType)
                    
                    
                }
            } else {
                
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
       */
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
