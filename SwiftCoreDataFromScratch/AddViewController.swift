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
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var authorName: UITextField!
    @IBOutlet weak var photoUrl: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clear out the textView
        textView.text = nil
        
        if bookObject != nil {
            bookTitle.text = bookObject.bookTitle
            authorName.text = bookObject.authorName
            photoUrl.text = bookObject.photoUrl
        }
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var bookObject: Book!

    
    // This function insert a book object (managed object) in the database then dismiss the view
    func insertManagedObject() {
        // Put the Book entity in the context
        let entityDescription = NSEntityDescription.entityForName("Book", inManagedObjectContext: context)
        
        // Create a managed object from the Book entity and put it in the context
        let bookObject = Book(entity: entityDescription!, insertIntoManagedObjectContext: context)
        
        // Set the managed object's properties
        bookObject.bookTitle = bookTitle.text!
        bookObject.authorName = authorName.text!
        bookObject.photoUrl = photoUrl.text!
        
        let savingError: NSError = NSError(domain: "context", code: 123, userInfo: nil)
        
        // Insert the managed object in the database file
        do{
            try context.save()
            // The context successfully inserted the managed object in the database, display a success message in the text view
            textView.text = "Book saved!"
            
            // Clear out the text fields
            bookTitle.text = nil
            authorName.text = nil
            photoUrl.text = nil
        } catch _ as NSError{
            // The context couldn't insert the managed object in the database, display an error message in the textView
            textView.text = "Failed to save the context with error = \(savingError.localizedDescription)"
        }
    }
    
    func getImage(urlString: String) -> UIImage {
        var imageObject = UIImage(named: "noimage")!
        
        // Strip spaces from either end of the String
        let trimmedUrlString = urlString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let imgUrl: NSURL = NSURL(string: trimmedUrlString)!
        
        // Make sure the urlString contain a valid url
        if imgUrl.scheme.isEmpty != true && imgUrl.host != nil {
            // Download an NSData representation of the image at the remote url
            let imgData = NSData(contentsOfURL: imgUrl)
            
            if imgData != nil {
                // Put the downloaded image in the variable
                imageObject = UIImage(data: imgData!)!
            }
        }
        
        // Return the local/downloaded image
        return imageObject
    }
    
    // This function update an existing managedObject in the database then dismiss the view
    func updateManagedObject() {
        // Reset the bookObject's properties with values entered in the text fields
        bookObject.bookTitle = bookTitle.text!
        bookObject.authorName = authorName.text!
        bookObject.photoUrl = photoUrl.text!
        
        let savingError: NSError = NSError(domain: "context", code: 123, userInfo: nil)
        
        do{
            try context.save()
            // The context successfully inserted the managed object in the database, display a success message in the text view
            textView.text = "Book saved!"
            
            // Clear out the text fields
            bookTitle.text = nil
            authorName.text = nil
            photoUrl.text = nil
        } catch _ as NSError{
            // The context couldn't insert the managed object in the database, display an error message in the textView
            textView.text = "Failed to save the context with error = \(savingError.localizedDescription)"
        }
    }

    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        // Dismiss the keyboard
        bookTitle.resignFirstResponder()
        authorName.resignFirstResponder()
        photoUrl.resignFirstResponder()
        
        // Make sure required text fields aren't empty
        if bookTitle.text!.isEmpty || authorName.text!.isEmpty {
            textView.text = "Both the Book Title and the Author Name is required"
            // Re-initialize the view's text fields with the previously selected managed object's properties
            bookTitle.text = bookObject.bookTitle
            authorName.text = bookObject.authorName
            photoUrl.text = bookObject.photoUrl
            return // Don't execute remaining code in the function
        }
        if bookObject == nil {
            insertManagedObject()
        } else {
            updateManagedObject()
        }
    }

    // This function is fired when you touch the view's background
   override func touchesBegan(touches: Set<UITouch>, withEvent e: UIEvent?) {
        // Dismiss the keyboard
        bookTitle.resignFirstResponder()
        authorName.resignFirstResponder()
        photoUrl.resignFirstResponder()
    
        // Load an image in the imageView control
        imageView.image = getImage(photoUrl.text!)
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
