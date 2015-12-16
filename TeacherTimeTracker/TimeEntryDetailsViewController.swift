//
//  TimeEntryDetailsViewController.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/9/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import UIKit
import Parse

class TimeEntryDetailsViewController: UIViewController {

    //required init(coder aDecoder: NSCoder) {
    //    fatalError("init(coder:) has not been implemented")
   // }

    //@IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var textViewStudents: UITextView!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelServiceType: UILabel!
    @IBOutlet weak var labelSubject: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    var subjectName = ""
    var notes = ""
  
    // Container to store the view table selected object
    var currentObject : PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //labelStudents.lineBreakMode = NSLineBreakMode.ByWordWrapping
       
        println(currentObject)
        
        var date = ""
        let serviceDate: AnyObject! = currentObject["endDateTime"]
        println(serviceDate)
        if serviceDate != nil {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM'-'dd'-'yyyy"
            date = dateFormatter.stringFromDate(serviceDate as NSDate)
            println(date)
        }
        labelDate.text = date

        if let subjectPtr: AnyObject = currentObject["subjectPtr"] {
            if let subjectName = subjectPtr["subjectName"] as? String {
                labelSubject.text = subjectName
            }
        } else {
            labelSubject.text = "Unknown"
        }
        
        if let serviceType = currentObject["serviceType"] as? String {
            labelServiceType.text = serviceType
        } else {
            labelServiceType.text = "Unknown"
        }
        
        if let durationString = currentObject["duration"] as Int! {
            labelDuration.text = String(durationString) + " min"
        } else {
            labelDuration.text = ""
        }
        
        // code to iterate students
        var relation = currentObject.relationForKey("studentRelation")
        self.textViewStudents.text = ""
        relation.query().findObjectsInBackgroundWithBlock {
            (relationObjects: [AnyObject]!, error: NSError?) -> Void in
            if let error = error {
                // There was an error
            } else {
                // objects has all the Posts the current user liked.
                
                for relationObject in relationObjects {
                    //println(relationObject)
                    var studentName = ""
                    if let _studentName = relationObject["studentName"] as? String {
                        //subjectName = relationObject["subjectName"] as String
                        studentName = _studentName
                        //self.labelStudents.text = self.labelStudents.text! + studentName
                        self.textViewStudents.text = self.textViewStudents.text! + studentName + "\n"
                        println(studentName)
                    }
                }
                
            }
        }
        textViewStudents.flashScrollIndicators()
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
