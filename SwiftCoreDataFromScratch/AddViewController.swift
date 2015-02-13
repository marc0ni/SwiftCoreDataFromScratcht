//
//  AddViewController.swift
//  SwiftCoreDataFromScratch
//
//  Created by Merlyn on 2/12/15.
//  Copyright (c) 2015 The App Lady. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var authorName: UITextField!
    @IBOutlet weak var photoUrl: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Clear out the textView
        textView.text = nil
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

    // This function is fired when you touch the view's background
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Dismiss the keyboard
        bookTitle.resignFirstResponder()
        authorName.resignFirstResponder()
        photoUrl.resignFirstResponder()
        
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
