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
    var subject:String = ""
    
    
    @IBAction func datePickerValueSelected(sender: UIDatePicker) {
        datePickerChanged()
    }
    
    @IBAction func selectedSubject(segue:UIStoryboardSegue) {
        if let subjectSelectionTableViewController = segue.sourceViewController as? SubjectSelectionTableViewController {
        //selectedSubject = subjectSelectionTableViewController.selectedGame
            let selectedSubject = subjectSelectionTableViewController.selectedSubject
            detailLabel.text = selectedSubject
            subject = selectedSubject!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePickerChanged()
        
        detailLabel.text = subject
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
        if indexPath.section == 2 && indexPath.row == 0 {
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
        if datePickerHidden && indexPath.section == 2 && indexPath.row == 1 {
            return 0
            
        }
        else {
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
        
        var cell3Index = NSIndexPath.init(forRow: 1, inSection: 2)
        var quantityCell = self.tableView.cellForRowAtIndexPath(cell3Index)
        if datePickerHidden {
            quantityCell?.hidden = true
        } else {
            quantityCell?.hidden = false
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
}
