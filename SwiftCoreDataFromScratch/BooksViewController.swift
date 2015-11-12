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
    
    var bookArray:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchManagedObjects()
    
        let request = NSFetchRequest(entityName: "Book")
        request.returnsObjectsAsFaults = false
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDelegate.managedObjectContext
        // since executeFetchRequest can return nil, cast it as an optional array of [BooksViewController]
        // note: the first [BooksViewController]? Can be omitted
        //var results : [BooksViewController]? = context.executeFetchRequest(request, error: nil) as? [BooksViewController]
        
        let error: NSError? = nil
        do {
            let results:[BooksViewController]? = try context.executeFetchRequest(request) as? [BooksViewController]
            let bookArray = results!   // check for nil and unwrap
            do {
                for authorName in bookArray {
                    print("The author's name is \(authorName).")
                }
                for bookTitle in bookArray {
                    print("The book's title is \(bookTitle).")
                }
                for photoUrl in bookArray {
                    print("The photo's URL is \(photoUrl).")
                }
            }

        } catch _ as NSError{
            print("Error: \(error?.localizedDescription)")
        }
    }
    
    
    //var books:NSArray = [Book]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /*func fetchResults(){
        //var error: NSError?
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Book")
        //let fetchResults = managedContext.executeFetchRequest(fetchRequest/*, error: &error*/) as? [Book]
        do {
            let fetchResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchResults {
                books = results
            }
        } catch {
            print("Could not fetch")
        }
        return fetchResults()
        
    }*/
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var bookObject: Book!
    var fetchedResultsController: NSFetchedResultsController!
    let collation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
    //var sections: [[Book]] = []
    /*var objects: [Book] = [] {
        didSet {
            let selector: Selector = "localizedTitle"
            
            sections = [[Book]](count: collation.sectionTitles.count, repeatedValue: [])
            
            let sortedBooks = collation.sortedArrayFromArray(objects, collationStringSelector: selector) as! [Book]
            for object in sortedBooks {
                let sectionNumber = collation.sectionForObject(object, collationStringSelector: selector)
                sections[sectionNumber].append(object)
            }
            
            self.tableView.reloadData()
        }
    }*/

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
    
    func partitionObjects(array:NSArray, collationStringSelector:Selector) -> NSArray {
        let collation:UILocalizedIndexedCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
        
        let sectionCount = collation.sectionTitles.count
        
        let unsortedSections = NSMutableArray(capacity: sectionCount)
        
        // Create array to hold data for each section
        for var i = 0; i < sectionCount; i++ {
            let emptyArray = NSMutableArray()
            unsortedSections.addObject(emptyArray);
        }
        
        // Put each object into a section
        for object in array{
            let index:Int = collation.sectionForObject(object, collationStringSelector: collationStringSelector)
            unsortedSections.objectAtIndex(index).addObject(object)
        }
        
        let sections = NSMutableArray(capacity: sectionCount)
        
        //sort each section
        for section in unsortedSections{
            sections.addObject(collation.sortedArrayFromArray(section as! NSMutableArray as [AnyObject], collationStringSelector: collationStringSelector))
        }
        
        return sections;
    }

    
    /*func partitionObjects(array:NSArray, collationStringSelector:Selector) -> NSArray{
        
        let collation:UILocalizedIndexedCollation = UILocalizedIndexedCollation.currentCollation() as UILocalizedIndexedCollation
        
        //section count is take from sectionTitles and not sectionIndexTitles
        let sectionCount = collation.sectionTitles.count
        
        let unsortedSections = NSMutableArray(capacity: sectionCount)
        
        //create an array to hold the data for each section
        for _ in collation.sectionTitles{
            let emptyArray = NSMutableArray()
            unsortedSections.addObject(emptyArray);
        }
        
        //put each object into a section
        for object in array{
            let index:Int = collation.sectionForObject(object, collationStringSelector: collationStringSelector)
            unsortedSections.objectAtIndex(index).addObject(object)
        }
        
        let sections = NSMutableArray(capacity: sectionCount)
        
        //sort each section
        for section in unsortedSections{
            sections.addObject(collation.sortedArrayFromArray(section as! NSMutableArray as [AnyObject], collationStringSelector: collationStringSelector))
        }
        
        return sections;
    }*/



    // MARK: - Table view data source (per UILocalizedIndexedCollation)
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        let numberOfSections = UILocalizedIndexedCollation.currentCollation().sectionTitles.count
        //println("numberOfSections: \(numberOfSections)")
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return (bookArray.count > 0) ? bookArray.objectAtIndex(section).count : 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if(bookArray.count > 0){
            let book = bookArray[indexPath.section][indexPath.row] as! Book
            
            // Configure the table view cell and return it
            let stringObject = book.photoUrl as String!
            cell.imageView!.image = AddViewController.getImage(stringObject)
            cell.textLabel!.text = book.bookTitle
            cell.detailTextLabel!.text = book.authorName
            
            //IMAGE:
            
            //RESIZING DONE IN CUSTOM TABLE CELL !!!!
            //cell.contactImageView.frame = CGRectMake(0, 0, 75, 75)
            
            /*if (contact.thumbnail != nil){
                cell.contactImageView.image = contact.thumbnail
            }else{
                cell.contactImageView.image = UIImage(named: "dummy")
            }*/
        }
        return cell
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let showSection:Bool = bookArray.objectAtIndex(section).count != 0
    
    //only show the section title if there are rows in the section
    return (showSection) ? (UILocalizedIndexedCollation.currentCollation().sectionTitles[section] as String) : nil;
    
    }

    
    /*func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return collation.sectionTitles[section] as String
    }*/
    
    func sectionIndexTitlesForTableView(tableView: UITableView!) -> [AnyObject]! {
        return collation.sectionIndexTitles
    }
    
    func tableView(tableView: UITableView!, sectionForSectionIndexTitle title: String!, atIndex index: Int) -> Int {
        return collation.sectionForSectionIndexTitleAtIndex(index)
    }


    /*func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections in the table view
        return fetchedResultsController.sections!.count
    }
    
    
    // MARK: - Table view data source (per UILocalizedIndexedCollation)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        let sectionInfo = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }*/
    
    
    /*func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // Put a managed object in the book object
        let book = fetchedResultsController.objectAtIndexPath(indexPath) as! Book
        
        
        // Configure the table view cell and return it
        let stringObject = book.photoUrl as String!
        cell.imageView!.image = AddViewController.getImage(stringObject)
        cell.textLabel!.text = book.bookTitle
        cell.detailTextLabel!.text = book.authorName
        return cell
    }*/
    
    //INDEX:
    
    /*func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        //sectionForSectionIndexTitleAtIndex: is a bit buggy, but is still useable
        return UILocalizedIndexedCollation.currentCollation().sectionForSectionIndexTitleAtIndex(index)
        
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return UILocalizedIndexedCollation.currentCollation().sectionIndexTitles
    }*/


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
   
    /*func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }*/
    
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
