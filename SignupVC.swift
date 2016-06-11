//
//  SignupVC.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/11/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignupVC: UIViewController {

	@IBOutlet weak var usernameField: UITextField!
	
	@IBOutlet weak var emailField: UITextField!
	
	@IBOutlet weak var passwordField: UITextField!
	
	@IBOutlet weak var confPasswordField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
	
	/* HELPER FUNCTIONS*/
	
	func signupInputIsValid() -> Bool {
		let username = usernameField.text
		let email = emailField.text
		let pwd = passwordField.text
		let conf = confPasswordField.text
		if username != nil && username != "" && email != nil && email != "" && pwd != nil && pwd != "" && conf != nil && conf != "" {
			return true
		} else {
			return false
		}
		
	}
	
	//check the password & password confirmation
	func passwordConfIsValid() -> Bool {
		if let pwd = passwordField.text where pwd != "", let conf = confPasswordField.text where conf == pwd {
			return true
		} else {
			return false
		}
	}
	
	//check all the inputs and show alerts if invalid
	func allInputIsValid() -> Bool {
		if self.signupInputIsValid() {
			if self.passwordConfIsValid() {
				return true
				
			}
				
			else {
				showAlertView("Please check your passwords", message: "Password confirmation has to be the same as password", target: self)
				return false
			}
			
		} else {
			showAlertView("Oops", message: "Please fill in all the fields.", target: self)
			return false
		}
	}
	
	/* IB ACTION FUNC*/
	@IBAction func cancelButtonPressed(sender: AnyObject) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	@IBAction func signupButtonPressed(sender: AnyObject) {
		guard allInputIsValid() else {
			return
		}
		
		let username = usernameField.text!
		let email = emailField.text!
		let password = passwordField.text!
		
		FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user:FIRUser?, error:NSError?) in
			if let error = error {
				
				print("Sign up failed with error: \(error.localizedDescription)")
				self.showAlertView("Sign up failed", message: error.localizedDescription, target: self)
				
			} else {
				UserSession.currentSession.currentUser = user!
				UserSession.currentSession.createUserNode(user!, username: username, email: email)
				self.dismissViewControllerAnimated(true, completion: nil)
				
			}
			
		})
		
		
		
	}
	

}
