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
	
	let userManager = KHUserManager.sharedManager
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }

	override func viewWillAppear(animated: Bool) {
		
	}
	
	override func viewDidAppear(animated: Bool) {
		
		//CHECK IF USER IS LOGGED IN
		if let user = FIRAuth.auth()?.currentUser {
			//user is logged in
			userManager.currentUser = user
			moveonAfterLogin()
		}

	}
	
	//MARK: - HELPER FUNCTIONS
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
		let homevc = KHHomePageViewController()
		self.navigationController?.pushViewController(homevc, animated: true)

	}
	
	//show alert to tell user to sign up
	func showAnynomousSigninAlert() {
		let alert = UIAlertController(title: "Temporary account", message: "We created an temporary account for you, if you decide to sign up, simply add your password and email!", preferredStyle: .Alert)
		let okAction = UIAlertAction(title: "Ok", style: .Default) { (action:UIAlertAction) in
			self.dismissViewControllerAnimated(true, completion:nil)
		}
		alert.addAction(okAction)
		self.presentViewController(alert, animated: true, completion: nil)
		
	}
	
	//MARK: - IB Actions
	@IBAction func singinButtonPressed(sender: AnyObject) {
		guard loginInputIsValid() else  {
			showAlertView("Invalid", message: "Please fill in both fields", target: self)
			return
		}
		
		FIRAuth.auth()?.signInWithEmail(emailText.text!, password: passwordText.text!, completion: { (user:FIRUser?, error:NSError?) in
			if let user = user {
				print("Sign in successful with user: \(user.uid)")
				self.userManager.currentUser = user
				
					self.emailText.text = ""
					self.passwordText.text = ""
				
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
        
        self .performSegueWithIdentifier("signInToHomePageSegue", sender: self)
        
		//sign in anonymously
		FIRAuth.auth()?.signInAnonymouslyWithCompletion({ (user:FIRUser?, error:NSError?) in
			if let user = user {
				print("Anonymous sign in success with user: \(user.uid)")
				self.userManager.currentUser = user
				self.userManager.createAnonymousUserNode(user)
				self.moveonAfterLogin()
			} else {
				print("Anonymous sign in failed \(error?.localizedDescription)")
				self.showAlertView("Sorry!", message: "We are sorry but there is some internal error, please come back later!", target: self)
			}
		})
		
		
	}
	

	
}
