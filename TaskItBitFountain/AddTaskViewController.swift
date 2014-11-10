//
//  AddTaskViewController.swift
//  TaskItBitFountain
//
//  Created by Brian Mendez on 11/8/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

//    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskButtonTapped(sender: UIButton) {
        
        //Core Data meat
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        //needs imported CoreData
        //pulls from TaskModel kind of like a Class/Struct
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.completed = false
        
        //saves
        appDelegate.saveContext()
        
        //needs to get back results, so we need to fetch results
        var request = NSFetchRequest(entityName: "TaskModel")
        var error : NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        for res in results {
            println(res)
        }
        
//removed for coreData!
//        var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
//        mainVC.baseArray[0].append(task)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
