//
//  ParseTesting.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/7/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import Foundation
import Bolts


func createParseTestTimeEntryObject(testObjectName: String) {
    var testObject = PFObject(className:"TestTimeEntry")
    testObject["timeEntryName"] = testObjectName
    testObject.saveInBackground()
}

func createParseTestSubjectObject(subjectName: String) {
    var subObj1 = PFObject(className:"TestSubject")
    subObj1["testSubjectName"] = subjectName
    subObj1.saveInBackground()
}

func getSubject(subjectName: String)
{
    var testQuery = PFQuery(className: "TestSubject")
    var mySubject = PFObject(className: "TestSubject")
    testQuery.whereKey("testSubjectName", equalTo: subjectName)

    let myPFC = PFCloudExt()
}

// example of getting an obect asynchronously
func getTestSubjectObjectAsync(subjectName: String) -> PFObject {
    var testQuery = PFQuery(className: "TestSubject")
    var mySubject = PFObject(className: "TestSubject")
    testQuery.whereKey("testSubjectName", equalTo: subjectName)
    testQuery.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]!, error: NSError!) -> Void in
        if error == nil {
            for object in objects {
                mySubject = object as PFObject
                println( object)
                println( mySubject)
                
                if let serviceTypeUnwrap = mySubject["testSubjectName"] as? String {
                    let mySubjectName = mySubject["testSubjectName"] as String
                    println(serviceTypeUnwrap)
                
                }
            }
            
            
        } else {
            
            // Log details of the failure
            NSLog("Error: %@ %@", error, error.userInfo!)
        }
    }
    return mySubject
}

// working example of how to a synchronous query on main thread
// this is not reccomended - timeouts will lock up the app/phone
func getTestSubjectObjectSynchrnous(subjectName: String) -> PFObject {
    var testQuery = PFQuery(className: "TestSubject")
    var myPFObject = PFObject(className: "TestSubject")
    testQuery.whereKey("testSubjectName", equalTo: subjectName)
    var messages = testQuery.findObjects() as [PFObject]
    for message in messages { // message is of PFObject type
        println(message)
        myPFObject = message
    }
    return myPFObject
}


func getTestSubject(
    subjectNameFilter:String,
    completion: (result: PFObject)->Void)
{
    var query = PFQuery(className:"TestSubject")
    var myPFObject = PFObject(className:"TestSubject")
    
    //if sortDescriptor.key != "" {
    //    query.orderBySortDescriptor(sortDescriptor)
    //}
    query.whereKey("testSubjectName", equalTo: subjectNameFilter)
    
    query.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]!, error: NSError!) -> Void in
        if error == nil {
            
            // Do something with the found objects
            for object in objects {
                // self.arrayOfObjects.append(object[parseObject]!!)
                myPFObject = object as PFObject
            }
            
        } else {
            // Log details of the failure
            println("Error: \(error) \(error.userInfo!)")
        }
        completion(result:myPFObject)
    }
    
}

// Example of how to iterate over relationships
func GetRelationships() {
    var testQuery = PFQuery(className: "Test")
    testQuery.whereKey("name", equalTo: "Test Me New 3")
    testQuery.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]!, error: NSError!) -> Void in
        if error == nil {
            for object in objects {
                println(object)
                var relation = object.relationForKey("testSubject")
                
                // code to iterate relationships
                relation.query().findObjectsInBackgroundWithBlock {
                    (relationObjects: [AnyObject]!, error: NSError?) -> Void in
                    if let error = error {
                        // There was an error
                    } else {
                        // objects has all the Posts the current user liked.
                        
                        for relationObject in relationObjects {
                            println(relationObject)
                            var subjectName = ""
                            if let subjectNameUnwrap = relationObject["subjectName"] as? String {
                                print( subjectNameUnwrap)
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
}

func SimpleTest () {
    let post = PFObject(withoutDataWithClassName: "Test", objectId: "pBQNem3sYK")
    let relation = post.relationForKey("testSubject")
    let sub = PFObject(withoutDataWithClassName: "TestSubject", objectId: "uwAKrcUJFM")
    relation.addObject(sub)
    post.saveInBackground()
}

// Code to add relationships - due to asynchrounous nature of the save and
//  query calls, this can get tricky
func AddRelationship() {
    

    var testQuery = PFQuery(className: "Test")
    testQuery.whereKey("name", equalTo: "Test Me New 3")
    testQuery.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]!, error: NSError!) -> Void in
        if error == nil {
            for object in objects {
                println(object)
                
                // code to add relations
                let myPFObject = object as PFObject
                //var relation = myPFObject.relationForKey("testSubject")
                
                let relation = myPFObject.relationForKey("testSubject")
                
                let sub = PFObject(withoutDataWithClassName: "TestSubject", objectId: "uwAKrcUJFM")
                let sub2 = PFObject(withoutDataWithClassName: "TestSubject", objectId: "OSfkQGnGoV")
                //let sub = getTestSubjectObjectAsync("Prog 901")
            
                
                relation.addObject(sub)
                relation.addObject(sub2)
                myPFObject.saveInBackgroundWithBlock {
                    (success: Bool!, error: NSError!) -> Void in
                    if (success != nil) {
                        println("Saved")
                        GetRelationships()
                    } else {
                        println("%@", error)
                    }
                
                }
            }
            
        } else {
            
            // Log details of the failure
            NSLog("Error: %@ %@", error, error.userInfo!)
        }
    }
}


 