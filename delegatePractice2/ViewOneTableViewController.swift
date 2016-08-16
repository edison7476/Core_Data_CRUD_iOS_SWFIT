//
//  ViewOneTableViewController.swift
//  delegatePractice2
//
//  Created by Jia Wang on 7/13/16.
//  Copyright © 2016 Jia Wang. All rights reserved.
//

import UIKit
import CoreData

class ViewOneTableViewController: UITableViewController, CancelButtonDelegate, SaveButtonDelegate {
    var person = [Person]()
    
    let manageObjContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        let entityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: manageObjContext)
        // in order to read, we must create a Fetch request
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        do{
            person = try manageObjContext.executeFetchRequest(request) as! [Person]
            if person.count > 0{
                self.tableView.reloadData()
            }
            else{
                Alert.show("No Record", message: "Database is empty", vc: self)
            }
        }
        catch let error as NSError{
            Alert.show("Error Occured", message: "\(error)", vc: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return person.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("view2Cell", forIndexPath: indexPath)
        cell.textLabel?.text = person[indexPath.row].personName
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nav = segue.destinationViewController as! UINavigationController
        let controller = nav.topViewController as! NoThreeTableViewController
        controller.cancelButtonDelegate = self
        controller.saveButtonDelegate = self
        
        if segue.identifier == "editCell" {
            // if we are trying to edit the exsiting data, we need to pass the exsiting data to NoThreeViewController
            // Otherwise we will get an error with data being nil. Also turn our editFlag to true
            var indexPath: NSIndexPath
            indexPath = self.tableView.indexPathForSelectedRow!
            controller.editFlag = true
            controller.person = person[indexPath.row]
        }
   
    }
//Delete Cell
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        manageObjContext.deleteObject(person[indexPath.row])
        person.removeAtIndex(indexPath.row)
        do{
            try manageObjContext.save()
        }
        catch{
            
        }
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
//cancelButtonDelegate
    func cancelButtonDelegate(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
//saveButtonDelegate
    func saveButtonPressedDelegate(controller: UIViewController, addingNewItem item: String, editFlag flag: Bool){
        dismissViewControllerAnimated(true, completion: nil)
       // person.append(item)
        print("editFlag: \(flag)")
        tableView.reloadData()
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
