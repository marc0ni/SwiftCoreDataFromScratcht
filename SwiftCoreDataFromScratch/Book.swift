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

    @NSManaged var title: String
    @NSManaged var photo: String
    @NSManaged var note: String

}
