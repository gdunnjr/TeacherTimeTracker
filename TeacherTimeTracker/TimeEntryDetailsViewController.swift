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
    
    @IBOutlet weak var labelSubject: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    var subjectName = ""
    var notes = ""
  
    // Container to store the view table selected object
    var currentObject : PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
         }
        
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
