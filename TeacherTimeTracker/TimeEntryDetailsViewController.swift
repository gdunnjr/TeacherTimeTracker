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

    @IBOutlet weak var subjectLabel: UILabel!
    
    var subjectName = ""
    var notes = ""
    // Container to store the view table selected object
    var currentObject : PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
