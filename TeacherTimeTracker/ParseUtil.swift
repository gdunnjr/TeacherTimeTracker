//
//  ParseUtil.swift
//  TeacherTimeTracker
//
//  Created by Gerald Dunn on 11/21/15.
//  Copyright (c) 2015 Gerald Dunn. All rights reserved.
//


import Foundation
import Bolts

class PFCloudExt: PFCloud {
    
    class func callFunctionAsync(
        name: NSString,
        withParameters parameters: NSDictionary) -> BFTask {
            
            let p = BFTaskCompletionSource()
            
            self.callFunctionInBackground(
                name,
                withParameters: parameters,
                block: {
                    (result: AnyObject!, error: NSError!) -> Void in
                    
                    if let result: AnyObject = result {
                        p.setResult(result)
                    } else {
                        p.setError(error)
                    }
                    
            })
            
            return p.task
    }
}

extension PFQuery {
    
    func getObjectWithIdAsync(objectId: String?) -> BFTask {
        
        let p = BFTaskCompletionSource()
        
        self.getObjectInBackgroundWithId(objectId, block: {
            (object: PFObject!, error: NSError!) -> Void in
            
            if let object = object {
                p.setResult(object)
            } else {
                p.setError(error)
            }
        })
        
        return p.task
    }
    
    func findObjectsAsync() -> BFTask {
        
        let p =  BFTaskCompletionSource()
        
        self.findObjectsInBackgroundWithBlock({
            (objects: Array<AnyObject>!, error: NSError!) -> Void in
            
            if let objects = objects {
                p.setResult(objects)
            } else {
                p.setError(error)
            }
        })
        
        return p.task
    }
    
    func getFirstObjectAsync() -> BFTask {
        
        let p = BFTaskCompletionSource()
        
        self.getFirstObjectInBackgroundWithBlock({
            (object: PFObject!, error: NSError!) -> Void in
            
            if let object = object {
                p.setResult(object)
            } else {
                p.setError(error)
            }
            
        })
        
        return p.task
    }
    
    func countObjectsAsync() -> BFTask {
        let p = BFTaskCompletionSource()
        
        self.countObjectsInBackgroundWithBlock({
            (count: Int32!, error: NSError!) -> Void in
            
            if let count = count {
                p.setResult(NSNumber(int: count))
            } else {
                p.setError(error)
            }
            
        })
        
        return p.task
    }
    
    
}