//
//  AddViewController.swift
//  SwiftCoreDataFromScratch
//
//  Created by Merlyn on 2/12/15.
//  Copyright (c) 2015 The App Lady. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var movieName: UITextField!
    @IBOutlet weak var movieFileUrl: UITextField!
    
    var bookRecord: Book!
    var fetchedResultsController: NSFetchedResultsController!
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // The user touched the view's background, so dismiss the keyboard
        movieName.resignFirstResponder()
        movieFileUrl.resignFirstResponder()
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
