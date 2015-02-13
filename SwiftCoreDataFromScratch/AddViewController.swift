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
    var bookRecord: Book!
    var fetchedResultsController: NSFetchedResultsController!
    let context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        // Dismiss the keyboard
        bookTitle.resignFirstResponder()
        authorName.resignFirstResponder()
        photoUrl.resignFirstResponder()
        
    }

    func getImage(urlString: String) -> UIImage {
        var imageObject = UIImage(named: "noimage")!
        let imgUrl: NSURL = NSURL(string: urlString)!
        
        // Make sure the urlString contain a valid url
        if imgUrl.scheme != nil && imgUrl.host != nil {
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
    
    // This function is fired when you touch the view's background
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Dismiss the keyboard
        bookTitle.resignFirstResponder()
        authorName.resignFirstResponder()
        photoUrl.resignFirstResponder()
        
        // Load an image in the imageView control
        imageView.image = getImage(photoUrl.text)
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
