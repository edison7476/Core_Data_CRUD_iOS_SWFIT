//
//  SaveButtonDeleagte.swift
//  delegatePractice2
//
//  Created by Jia Wang on 7/13/16.
//  Copyright © 2016 Jia Wang. All rights reserved.
//


import UIKit

protocol SaveButtonDelegate: class {
    func saveButtonPressedDelegate (controller: UIViewController, addingNewItem item: String, editFlag flag: Bool)
}