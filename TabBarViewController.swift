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
    
    
    // MARK: These functions were written to kick the tires on parse. 
    // No purpose for them now so commented out
    /*
    func TestOutParse() {
        //createParseTestSubjectObject("Math")
        createParseTestSubjectObject("Science")
        
        // asynchrounous example
        getTestSubjectObjectAsync("Math")
        
        
        var myPFMathObject = PFObject(className:"TestSubject")
        myPFMathObject = getTestSubjectObjectSynchrnous("Math")
        println(myPFMathObject)
        
        // Example of using a completion block - still async
        getTestSubject("Math")
            {
                (result: PFObject) in
                //println(result)
                var myPFObject = result as PFObject
                //println(myPFObject)
                
        }
    }
    */
}
