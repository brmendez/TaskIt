//
//  ViewController.swift
//  TaskItBitFountain
//
//  Created by Brian Mendez on 11/8/14.
//  Copyright (c) 2014 Brian Mendez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //chaining .managedObjectContext to end. Nice! different in other VC!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultsController = NSFetchedResultsController() as NSFetchedResultsController

    //removed for coredata
//    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchedResultsController = getFetchResultsController()
        //need to conform to protocol, add NSFetchedResultsControllerDelegate. Now able to call functions in THIS viewcontroller
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        //commented out for CoreData!!!!!!!!!!!!!!!!!!!!!!
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        
//        let date1 = Date.from(year: 2014, month: 05, day: 20)
//        let date2 = Date.from(year: 2014, month: 03, day: 3)
//        let date3 = Date.from(year: 2014, month: 12, day: 13)
//        
//        let task1 = TaskModel(task: "Study French", subTask: "Verbs", date: date1, completed: false)
//        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2, completed: false)
//
//        let taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg Day", date: date3, completed: false)]
//        
//        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
//        
//        baseArray = [taskArray, completedArray]
//        
//        self.tableView.reloadData()
        
    }
    
    // gets called when transitioning BACK from addtaskviewcontroller
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        //sorts dates by timeInterval
//        func sortByDate (taskOne: TaskModel, taskTwo: TaskModel) -> Bool {
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        
//        taskArray = taskArray.sorted(sortByDate)
        
        //removed for CD
//        baseArray[0] = baseArray[0].sorted {
//            (taskOne: TaskModel, taskTwo: TaskModel) -> Bool in
//            //comparison logic here
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTaskDetail" {
            let detailVC = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.detailTaskModel = thisTask
            //added after adding mainVC as property of type ViewController!
            //can remove
//            detailVC.mainVC = self

        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC = segue.destinationViewController as AddTaskViewController
            //passes this VC's properties over to the AddTaskViewController. That AddTaskVC has a property to catch all this
//            addTaskVC.mainVC = self
            
        }
        
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //removed for coredata
        //        return baseArray.count
               return fetchedResultsController.sections!.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//removed for coreData
//        return baseArray[section].count
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        println("cell for row")
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        println(indexPath)
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("CELL") as TaskCell
            //changes to lower case t's
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }

    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        } else {
            return "Completed"
        }
    }
    
    //allows swipe ability
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
            
            thisTask.completed = true
//removed for CD
//            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
//            //the swipe
//            //after deleting, the newTask is now appended to index spot 1 in baseArray (completed tasks)
//            baseArray[1].append(newTask)
        }
        else {
            thisTask.completed = false
//            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
//            baseArray[0].append(newTask)
        }
        //now Save after the stuff above
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()

        
//            baseArray[indexPath.section].removeAtIndex(indexPath.row)
//            tableView.reloadData()
        //NSfetchedResultsControllerDelegate
        func controllerDidChangeContent(controller: NSFetchedResultsController) {
            tableView.reloadData()
        }
       
    }

    //Helper
    //more CoreData meat
    //looks for all task models via Sort Descriptor, sorted by date
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        //while typing sortDescriptors, it says it returns array of AnyObject, hench [sortDescriptor]
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    //responsible for monitoring entity changes
    func getFetchResultsController() -> NSFetchedResultsController {
        var fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchedResultsController
    }
}