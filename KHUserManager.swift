//
//  UserSession.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/9/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

/* User manages manages and stores a */

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseAnalytics

class KHUserManager :NSObject {
	static let sharedManager = KHUserManager()
	
	var currentUser: FIRUser?
	
	var logedIn: Bool!
	
	//basic info
	 var username: String!
	 var email: String!
	 var uid: String!


	
	//Config info
	
	var patient = KHUser()
	
	override init() {
		logedIn = false
		username = ""
		email = ""
		uid = ""

	}
	
	
	func configureWithUser(user: FIRUser) {
		self.currentUser = user
		if let email = user.email {
			self.email = email
		}
		self.uid = user.uid
		self.logedIn = true
	}
	
	func createEmailUserNode(user: FIRUser, username: String, email: String) {
		let node = [KEY_FIR_USER_ID:user.uid,
		            KEY_FIR_USER_EMAIL:email,
		            KEY_FIR_USERNAME:username,
		            KEY_FIR_PROVIDER:"email"]
		FIRService.sharedService.refUsers.child(user.uid).updateChildValues(node) { (error:NSError?, ref:FIRDatabaseReference?) in
			if let error = error {
				print("create user node failed with error: \(error.localizedDescription)")
			} else {
				print("Create user node success: \(ref!)")
			}
			
		}
	}
	
	func createAnonymousUserNode(user: FIRUser) {
		let node = [KEY_FIR_USER_ID:user.uid,
		            KEY_FIR_PROVIDER:"anonymous"]
		FIRService.sharedService.refUsers.child(user.uid).updateChildValues(node) { (error:NSError?, ref:FIRDatabaseReference) in
			if let error = error  {
				print("Create anynomous user failed: \(error.localizedDescription)")
			} else {
				print("Craete anynomous user success: \(ref)")
			}
		}
	}
	
	func uploadPatientInfo() {
		if let user = FIRAuth.auth()?.currentUser{
			let ref = FIRService.sharedService.refUsers.child(user.uid).child(KEY_FIR_BASIC_INF)
			let dict = dictWithBasicInfo()
			ref.updateChildValues(dict, withCompletionBlock: { (err:NSError?, ref:FIRDatabaseReference) in
				if let err = err {
					print(err.localizedDescription)
				} else {
					print("upload patient basic info success: \(ref)")
				}
			})
			
		}
		
		//log anonymous analytics data
		self.logFIRProperties()
		self.logEventCompletedBasicQuestions()
	}
	
	func dictWithBasicInfo() -> Dictionary<String, AnyObject> {
		let info = KHUserManager.sharedManager.patient
		
		let dict: Dictionary<String,AnyObject> =
			["firstName":info.firstName,
			 "lastName":info.lastName,
			 "birthday":info.birthdayString,
			 "ethnicity":info.ethnicity,
			 "age":info.age]
		
		return dict
	}
	
	func logFIRProperties() {
		let info = KHUserManager.sharedManager.patient
		//log user ethnicity
		FIRAnalytics.setUserPropertyString(info.ethnicity, forName: "ethnicity")
		
		FIRAnalytics.setUserPropertyString(info.gender, forName: "Gender")
	}
	
	
	
	func logEventCompletedBasicQuestions() {
		FIRAnalytics.logEventWithName("completed_basic_questions", parameters: nil)
	}
	
	
}