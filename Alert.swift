//
//  Alert.swift
//  CoreDataStore
//
//  Created by Jia Wang on 7/13/16.
//  Copyright © 2016 Jia Wang. All rights reserved.
//

import UIKit

class Alert: NSObject{
    static func show(title:String, message:String, vc: UIViewController){
        let alertCT = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAc = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            (alert: UIAlertAction) -> Void in alertCT.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertCT.addAction(okAc)
        
        vc.presentViewController(alertCT, animated: true, completion: nil)
    }
}