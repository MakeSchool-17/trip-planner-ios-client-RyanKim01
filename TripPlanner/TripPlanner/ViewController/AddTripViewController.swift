//
//  AddTripViewController.swift
//  TripPlanner
//
//  Created by Ryan Kim on 10/30/15.
//  Copyright © 2015 RKProduction. All rights reserved.
//

import UIKit
import Foundation

class AddTripViewController: UIViewController {

    @IBOutlet weak var addTripTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTripTextField.delegate = self
    }
}

extension AddTripViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addTripTextField.resignFirstResponder()
        return true
    }
}
