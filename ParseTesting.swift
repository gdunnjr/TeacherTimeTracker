//
//  ParseTesting.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 8/7/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//

import Foundation


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


// example of getting an obect asynchronously
func getTestSubjectObjectAsync(subjectName: String) {
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
    var testQuery = PFQuery(className: "TestObject")
    testQuery.whereKey("foo", equalTo: "Test Me New 999")
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
}

// Code to add relationships - due to asynchrounous nature of the save and
//  query calls, this can get tricky
func AddRelationshipTest() {
    var subObj1 = PFObject(className:"TestSubject")
    subObj1["subjectName"] = "Prog 900"
    subObj1.saveInBackground()
    
    var subObj2 = PFObject(className:"TestSubject")
    subObj2["subjectName"] = "Prog 901"
    subObj2.saveInBackground()
    
    
    var testObject = PFObject(className:"TestObject")
    testObject["foo"] = "Test Me New 999"
    testObject.saveInBackground()
    
    var testQuery = PFQuery(className: "TestObject")
    testQuery.whereKey("foo", equalTo: "Test Me New 999")
    testQuery.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]!, error: NSError!) -> Void in
        if error == nil {
            for object in objects {
                println(object)
                
                // code to add relations
                let myPFObject = object as PFObject
                var relation = object.relationForKey("subjectPtr")
                relation.addObject(subObj1)
              //  relation.addObject(subObj2)
                myPFObject.saveInBackgroundWithBlock {
                    (success: Bool!, error: NSError!) -> Void in
                    if (success != nil) {
                        println("Saved")
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



func AddStudentsRelationshipTest() {
    
    var stuObj1 = PFObject(className:"Student")
    stuObj1["studentName"] = "Kelly, Jim"
    stuObj1.saveInBackgroundWithBlock( {
        (success: Bool!, error: NSError!) -> Void in
        if (success != nil) {
            NSLog("Object created with id: (stuObj1.objectId)")
        } else {
            NSLog("%@", error)
        }
    })
    
    var stuObj2 = PFObject(className:"Student")
    stuObj2["studentName"] = "Thomas, Thurman"
    stuObj2.saveInBackgroundWithBlock( {
        (success: Bool!, error: NSError!) -> Void in
        if (success != nil) {
            NSLog("Object created with id: (stuObj2.objectId)")
        } else {
            NSLog("%@", error)
        }
    })
    
    var testQuery = PFQuery(className: "Class")
    testQuery.whereKey("classDescription", equalTo: "Resource 7 Dunn")
    testQuery.findObjectsInBackgroundWithBlock {
        (objects: [AnyObject]!, error: NSError!) -> Void in
        if error == nil {
            for object in objects {
                println(object)
                
                // code to add relations
                let myPFObject = object as PFObject
                
                var relation = myPFObject.relationForKey("Students") as PFRelation
                
                println(relation)
                
                relation.addObject(stuObj1)
                relation.addObject(stuObj2)
                myPFObject.saveInBackgroundWithBlock {
                    (success: Bool!, error: NSError!) -> Void in
                    if (success != nil) {
                        println("Saved")
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




 