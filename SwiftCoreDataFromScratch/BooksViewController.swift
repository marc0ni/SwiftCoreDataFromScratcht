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
        fetchManagedObjects()
    }
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var bookObject: Book!
    var fetchedResultsController: NSFetchedResultsController!


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchManagedObjects() {
        // Setup the fetch request with a sortDescriptor for the fetchedResultController
        let fetchRequest = NSFetchRequest(entityName: "Book")
        
        fetchRequest.fetchLimit = 25
        
        let sortDescriptor = NSSortDescriptor(key: "bookTitle", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Pass the fetchRequest and the context as parameters to the fetchedResultController
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:context,sectionNameKeyPath: nil, cacheName: nil)
        
        // Make the fetchedResultsController a delegate of this class
        fetchedResultsController.delegate = self
        
        // Execute the fetch request or display an error message in the Debugger console
        let error: NSError? = nil
        do {
            try fetchedResultsController.performFetch()
        } catch _ as NSError{
            print("Error: \(error?.localizedDescription)")
        }
    }


    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections in the table view
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        let sectionInfo = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // Put a managed object in the book object
        let book = fetchedResultsController.objectAtIndexPath(indexPath) as! Book
        
        
        // Configure the table view cell and return it
        let stringObject = book.photoUrl as String!
        cell.imageView!.image = AddViewController.getImage(stringObject)
        cell.textLabel!.text = book.bookTitle
        cell.detailTextLabel!.text = book.authorName
        return cell
    }

    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObjectToDelete = fetchedResultsController.objectAtIndexPath(indexPath) as! Book
        context.deleteObject(managedObjectToDelete)
        
        let savingError: NSError = NSError(domain: "context", code: 123, userInfo: nil)
        do {
            try context.save()
        } catch _ as NSError{
            // The context couldn't insert the managed object in the database, display an error message in the textView
            print("Failed to save the context with error = \(savingError.localizedDescription)")
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
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        if !searchText.isEmpty {
            // Clear out the fetchedResultController
            fetchedResultsController = nil
            
            // Setup the fetch request
            let fetchRequest = NSFetchRequest(entityName: "Book")
            
            fetchRequest.fetchLimit = 25
            fetchRequest.predicate = NSPredicate(format: "bookTitle contains[cd] %@", searchText)
            
            let sortDescriptor = NSSortDescriptor(key: "bookTitle", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            // Pass the fetchRequest and the context as parameters to the fetchedResultController
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:context, sectionNameKeyPath: nil, cacheName: nil)
            
            // Make the fetchedResultController a delegate of the MoviesViewController class
            fetchedResultsController.delegate = self
            
            // Execute the fetch request or display an error message in the Debugger console
            let error: NSError? = nil
            
            do {
                try fetchedResultsController.performFetch()
            } catch _ as NSError{
                 print("Error: \(error?.localizedDescription)")
            }
            
            // Refresh the table view to show search results
            tableView.reloadData()
        }
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar!) {
        searchBar.text = nil
        searchBar.showsCancelButton = false // Hide the cancel
        searchBar.resignFirstResponder() // Hide the keyboard
        fetchManagedObjects()
        
        // Refresh the table view to show fetchedResultController results
        tableView.reloadData()
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
