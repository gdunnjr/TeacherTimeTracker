//
//  TimeEntryTableViewController.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/7/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TimeEntryTableViewController: PFQueryTableViewController , UITableViewDelegate{
    
    var sections = [String : Array<Int>]()
    var sectionToSportTypeMap = NSMutableDictionary()
   
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "TimeEntry"
        self.textKey = "notes"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "TimeEntry")
        query.orderByAscending("startDateTime")
        query.includeKey("subjectPtr")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject) -> PFTableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as PFTableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TimeEntryTableViewCell
        var durationString = ""
        if let durationPtr = object["duration"] as Int! {
            durationString = String(durationPtr) + "min"
        } else {
            durationString = ""
        }
        
        cell.hoursLabel?.text = durationString
        cell.detailTextLabel?.text = object["notes"] as String!
        if let pointer = object["subjectPtr"] as? PFObject {
            cell.textLabel?.text = pointer["subjectName"] as String!
        }
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "timeEntrySegue" {
        //    if let destination = segue.destinationViewController as? BlogViewController {
        //        if let blogIndex = tableView.indexPathForSelectedRow()?.row {
        //            destination.blogName = swiftBlogs[blogIndex]
        //        }
        //    }
        }
    }
    
    override func objectsDidLoad(error: NSError!) {
        
        super.objectsDidLoad(error)
        
        sections.removeAll(keepCapacity: false)
        sectionToSportTypeMap.removeAllObjects()
        
    
        var section = 0

        var rowIndex = 0
        
        
        
        for object in objects {
            println(object)
            println(object["startDateTime"])
    
            var date = ""
            var startDateTime = object["startDateTime"]
            if startDateTime != nil {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM'/'dd'/'yyyy"
                let origDate = dateFormatter.stringFromDate(startDateTime as NSDate)
                println(origDate)
                date = getDayOfWeek(origDate) + " " + date
                
                let dateFormatter2: NSDateFormatter = NSDateFormatter()
                let months = dateFormatter2.shortMonthSymbols
                let monthSymbol = months[8-1] as String // month - from your date components

                let dateFormatter3 = NSDateFormatter()
                dateFormatter3.dateFormat = "yyyy"
                let date3 = dateFormatter3.stringFromDate(startDateTime as NSDate)
                println(date3)
                
                println(monthSymbol)
                
                let dayTimePeriodFormatter = NSDateFormatter()
                dayTimePeriodFormatter.dateFormat = "EEEE, MMM d, yyyy"
                let dateString = dayTimePeriodFormatter.stringFromDate(startDateTime as NSDate)

                println(dateString)
                date = dateString
            }
            
            let sport = date
            var objectsInSection = sections[sport]
            
            if (objectsInSection == nil) {
                
                objectsInSection = Array<Int>()
                
                sectionToSportTypeMap[section++] = sport
                
            }
            
            objectsInSection?.append(rowIndex++)
            
            sections[sport] = objectsInSection
            println(sections.count)
            
        }
        self.tableView.reloadData()
    }
    
    func sportTypeForSection(section: NSInteger) -> NSString {
        return sectionToSportTypeMap.objectForKey(section) as NSString
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sport = sportTypeForSection(section)
        let rowIndecesInSection = sections[sport]!
        return rowIndecesInSection.count
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sport = sportTypeForSection(section)
        return sport
    }

    func getDayOfWeek(today:String)->String {
        var weekDayName = ""
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy" //"yyyy-MM-dd"
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.CalendarUnitWeekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            switch weekDay {
            case 0:
                weekDayName = "Sunday"
            case 1:
                weekDayName = "Monday"
            case 2:
                weekDayName = "Tuesday"
            case 3:
                weekDayName = "Wednesday"
            case 4:
                weekDayName = "Thursday"
            case 5:
                weekDayName = "Friday"
            case 6:
                weekDayName = "Saturday"
            case 7:
                weekDayName = "Sunday"
            default:
                weekDayName = ""
            }
            
            return weekDayName
        } else {
            return ""
        }
    }

    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 0/255, green: 80/255, blue: 255/255, alpha: 1.0) //make the background color light blue
        header.textLabel.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 0.5 //make the header transparent
    }
    
    /*
    func getSectionItems(section: Int) -> [DateTextItem] {
        var sectionItems = [DateTextItem]()
        
        // loop through the testArray to get the items for this sections's date
        for item in testArray {
            let dateTextItem = item as DateTextItem
            let df = NSDateFormatter()
            df.dateFormat = "MM/dd/yyyy"
            let dateString = df.stringFromDate(dateTextItem.insertDate)
            
            // if the item's date equals the section's date then add it
            if dateString == sectionsInTable[section] as NSString {
                sectionItems.append(dateTextItem)
            }
        }
        
        return sectionItems
    }
*/
    
  /*  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2 //sectionsInTable.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.getSectionItems(section).count
    
        return section + 1
    }
*/

}
