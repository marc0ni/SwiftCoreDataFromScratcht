//
//  Book.swift
//  SwiftCoreDataFromScratch
//
//  Created by Merlyn on 2/12/15.
//  Copyright (c) 2015 The App Lady. All rights reserved.
//

import Foundation
import CoreData

class Book: NSManagedObject {

    @NSManaged var authorName: String
    @NSManaged var bookTitle: String
    @NSManaged var photoUrl: String

}
