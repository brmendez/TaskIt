//
//  TaskModel.swift
//  TaskItBitFountain
//
//  Created by Brian Mendez on 11/8/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import Foundation
import CoreData

@objc (TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
