//
//  TimeEntryInsertTableViewController.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/11/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import UIKit

class TimeEntryInsertTableViewController: UITableViewController {


    @IBOutlet weak var detailDateLabek: UILabel!
    //@IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var serviceDescTextBox: UITextField!
    var datePickerHidden = true
    var subject:String = "N/A"
    var student:String = "N/A"
    var selectedSubjectObject : PFObject! = nil
    var selectedStudentsObject : NSMutableArray = []
    var selectedStudents:[String] = []
    
    @IBOutlet weak var detailSubjectLabel: UILabel!
    
    @IBAction func datePickerValueSelected(sender: UIDatePicker) {
        datePickerChanged()
    }
    
    @IBOutlet weak var SliderDuration: UISlider!
    @IBOutlet weak var LabelSlider: UILabel!
  
    @IBAction func selectedSubject(segue:UIStoryboardSegue) {
        if let subjectSelectionTableViewController = segue.sourceViewController as? SubjectSelectionTableViewController {
        //selectedSubject = subjectSelectionTableViewController.selectedGame
            let selectedSubject = subjectSelectionTableViewController.selectedSubject
            //detailLabel.text = selectedSubject
            detailSubjectLabel.text = selectedSubject
            subject = selectedSubject!
            selectedSubjectObject = subjectSelectionTableViewController.selectedSubjectObject
        }
    }
    
    @IBAction func saveSelectedStudents(segue:UIStoryboardSegue) {
        if let studentSelectionTableViewController = segue.sourceViewController as? StudentsSelectionTableViewController {
            let selectedStudent = studentSelectionTableViewController.selectedStudent
            detailLabel.text = selectedStudent
            student = selectedStudent!
            selectedStudentsObject = studentSelectionTableViewController.studentArray
            selectedStudents = studentSelectionTableViewController.selectedStudents
            
        }
    }
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        
        LabelSlider.text = "\(currentValue)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerChanged()
        
        detailLabel.text = student
        detailSubjectLabel.text = subject
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            serviceDescTextBox.becomeFirstResponder()
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            toggleDatepicker()
        }
    }
    
    func datePickerChanged () {
        
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMMM, dd yyyy"
        
        detailDateLabek.text = dayTimePeriodFormatter.stringFromDate(datePicker.date)
        //dateString now contains the string "Thursday, 7 AM".
        //detailDateLabek.text = NSDateFormatter.localizedStringFromDate(datePicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 1 && indexPath.row == 1 {
            return 0
            }
        else {
            println(indexPath.section)
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
   // override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //
        //if(indexPath.section == 2 &&  indexPath.row == 1 && datePickerHidden){
         //
          //  myCell?.hidden = true
       // }
       //
        //return myCell!
   // }
    
    func toggleDatepicker() {
        
        datePickerHidden = !datePickerHidden
        //datePicker.hidden = datePickerHidden
        
        var cell3Index = NSIndexPath.init(forRow: 1, inSection: 1)
        var quantityCell = self.tableView.cellForRowAtIndexPath(cell3Index)
        if datePickerHidden {
            quantityCell?.hidden = true
        } else {
            quantityCell?.hidden = false
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "saveInsertTimeEntry" { // you define it in the storyboard (click on the segue, then Attributes' inspector > Identifier
            var segueShouldOccur = true
            var subjectSelected = false
            var studentsSelected = false
            var errorMessage = ""
        
            if (selectedSubjectObject == nil) {
                errorMessage += "Subject must be selected. Please select a subject.\n"
            }
            for var index = 0; index < selectedStudents.count; ++index {
                if (selectedStudents[index] == "Y") {
                    studentsSelected = true
                }
                
            }

            if (!studentsSelected) {
                errorMessage += "A student must be selected. Please select a student.\n"
            }
            
            if (errorMessage != "") {
                segueShouldOccur = false
                let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                segueShouldOccur = true
            }
            
            if !segueShouldOccur {
                println("*** NOPE, segue wont occur")
                return false
            }
            else {
                println("*** YEP, segue will occur")
            }
        }
        
        // by default, transition
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectSubjectSegue" {
            if let subjectPickerViewController = segue.destinationViewController as? SubjectSelectionTableViewController {
                subjectPickerViewController.selectedSubject = subject
            }
        }
        if segue.identifier == "saveInsertTimeEntry" {
            //if let subjectPickerViewController = segue.destinationViewController as? SubjectSelectionTableViewController {
                //subjectPickerViewController.selectedSubject = subject
            //}
            let x="x"
            println(datePicker.date)
            
            var object = PFObject(className:"TimeEntry")
            object["startDateTime"] = datePicker.date
            object["endDateTime"] = datePicker.date
            object["subjectPtr"] = selectedSubjectObject
            object["duration"] = SliderDuration.value
            
            println(SliderDuration.description)
            
            //var relation = object.relationForKey("subjectPtr")
            //relation.addObject(selectedSubjectObject)
            println(selectedStudents.count)
            
            for var index = 0; index < selectedStudents.count; ++index {
                print("index is \(index) selected is \(selectedStudents[index])")
                if (selectedStudents[index] == "Y") {
                    var relation = object.relationForKey("studentRelation")
                    relation.addObject(selectedStudentsObject[index] as PFObject)
                }
                
            }
                
            object.saveInBackgroundWithBlock {
                (success: Bool!, error: NSError!) -> Void in
                if (success != nil) {
                    println("Saved")
                } else {
                    println("%@", error)
                }
            }

            
        }
        
    }
    
    
}
