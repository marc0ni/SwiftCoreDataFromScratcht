//
//  BooksViewController.swift
//  SwiftCoreDataFromScratch
//
//  Created by Merlyn on 2/12/15.
//  Copyright (c) 2015 The App Lady. All rights reserved.
//

import UIKit
import CoreData


class BooksViewController: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    var bookObject: Book!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObjectToDelete = fetchedResultsController.objectAtIndexPath(indexPath) as Book
        context.deleteObject(managedObjectToDelete)
        
        let savingError: NSError?
        do {
            try context.save()
        } catch _ as NSError{
            // The context couldn't insert the managed object in the database, display an error message in the textView
            print ("Failed to save the context with error = \(savingError?.localizedDescription)")
        }

    }
    
    
    // MARK: -  NSFetchedResultsController delegate functions    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if type == .Delete {
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        } else if type == .Insert {
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        } else if type == .Update {
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
