//
//  Date.swift
//  TaskItBitFountain
//
//  Created by Brian Mendez on 11/8/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import Foundation

class Date {
    
    class func from (#year:Int, month: Int, day: Int) -> NSDate {
    
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
    
    class func toString(#date:NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
    
        return dateString
    }

}