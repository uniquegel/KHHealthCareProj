//
//  SigninVC.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/10/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseDatabase

class SigninVC: UIViewController {

	
	@IBOutlet weak var emailText: UITextField!
	@IBOutlet weak var passwordText: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }

	override func viewWillAppear(animated: Bool) {
		
	}
	
	override func viewDidAppear(animated: Bool) {
		//CHECK IF USER IS LOGGED IN
		if let user = FIRAuth.auth()?.currentUser {
			//user is logged in
			UserSession.currentSession.currentUser = user
			moveonAfterLogin()
		}

	}
	
	/** HELPER FUNCTIONS**/
	func loginInputIsValid() -> Bool {
		let usrname = emailText.text
		let pwd = passwordText.text
		if usrname != nil && usrname != "" && pwd != nil && pwd != "" {
			return true
		} else {
			return false 
		}
		
	}
	
	func moveonAfterLogin() {
		//Clear the log in fields
		self.emailText.text = ""
		self.passwordText.text = ""
		self.performSegueWithIdentifier(SEGUE_SIGNIN_TO_HOME, sender: self)
	}
	
	
	/** IB ACTIONS  **/
	@IBAction func singinButtonPressed(sender: AnyObject) {
		guard loginInputIsValid() else  {
			showAlertView("Invalid", message: "Please fill in both fields", target: self)
			return
		}
		
		FIRAuth.auth()?.signInWithEmail(emailText.text!, password: passwordText.text!, completion: { (user:FIRUser?, error:NSError?) in
			if let user = user {
				print("Sign in successful with user: \(user.uid)")
				UserSession.currentSession.currentUser = user
				self.moveonAfterLogin()
				
			} else {
				print("Sign in failed with error: \(error!.localizedDescription)")
				self.showAlertView("Log in failed", message: error!.localizedDescription, target: self)
			}
		})
		
	}
	
	@IBAction func signupButtonPressed(sender: AnyObject) {
		self.performSegueWithIdentifier(SEGUE_SIGNIN_TO_SIGNUP, sender: self)
	}
	
	@IBAction func skipButtonPressed(sender: AnyObject) {
		
	}
	
}
