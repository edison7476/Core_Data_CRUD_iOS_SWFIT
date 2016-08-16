//
//  NoThreeTableViewController.swift
//  delegatePractice2
//
//  Created by Jia Wang on 7/13/16.
//  Copyright © 2016 Jia Wang. All rights reserved.
//

import UIKit
import CoreData

class NoThreeTableViewController: UITableViewController {
    
    var editFlag = false
    var person: Person?
    
    let manageObjContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var saveButtonDelegate: SaveButtonDelegate?
    
    @IBOutlet weak var textFiled: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editFlag == true {
            print("editing mode")
            textFiled.text = person!.personName
        }
        else {
            print("Creating mode")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func cancelButton(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonDelegate(self)
    }
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
        saveButtonDelegate?.saveButtonPressedDelegate(self, addingNewItem: textFiled.text, editFlag: editFlag)
        
        if editFlag == false {
            let entityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: manageObjContext)
            person = Person(entity: entityDescription!, insertIntoManagedObjectContext: manageObjContext)
        }
        person!.personName = textFiled.text
        do {
            try manageObjContext.save()
            Alert.show("Success", message: "Successfully save the data", vc: self)
        }
        catch let error as NSError{
            Alert.show("Failed", message: "\(error)", vc: self)
        }
    }
    //loading cell data
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
