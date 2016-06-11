//
//  UserSession.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/9/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseAnalytics

class UserSession: NSObject {
	static let currentUser = UserSession()
	
	var currentUser: FIRUser?
	
	var logedIn: Bool!
	
	//basic info
	 var username: String!
	 var email: String!
	 var uid: String!

	//patient info
	var birthday: NSDate!
	var ethnicity: String!
	var heightCM: Double!
	var heightFeet: Int!
	var heightInches: Int!
	var weightKg: Double!
	var gender: String!
	
	//Config info
	var completedBasicQuestions: Bool = false
	
	var basicInfo:BasicInfo!
	
	override init() {
		logedIn = false
		username = ""
		email = ""
		uid = ""
		birthday = NSDate(timeIntervalSince1970: 0)
		ethnicity = ""
		heightCM = 0
		heightFeet = 0
		heightInches = 0
		weightKg = 0
		gender = ""
		
		basicInfo = BasicInfo()
	}
	
	
	func configureWithUser(user: FIRUser) {
		self.currentUser = user
		if let email = user.email {
			self.email = email
		}
		self.uid = user.uid
		self.logedIn = true
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
		let info = UserSession.currentUser.basicInfo
		let dict: Dictionary<String,AnyObject> =
			["firstName":info.firstName,
			 "lastName":info.lastName,
			 "birthday":info.birthdayString,
			 "ethnicity":info.ethnicity,
			 "age":info.age]
		
		return dict
	}
	
	func logFIRProperties() {
		let info = UserSession.currentUser.basicInfo
		//log user ethnicity
		FIRAnalytics.setUserPropertyString(info.ethnicity, forName: "ethnicity")
		
		FIRAnalytics.setUserPropertyString(info.gender, forName: "Gender")
	}
	
	
	
	func logEventCompletedBasicQuestions() {
		FIRAnalytics.logEventWithName("completed_basic_questions", parameters: nil)
	}
	
	
}