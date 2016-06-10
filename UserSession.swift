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

class UserSession: NSObject {
	static let currentSession = UserSession()
	
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
		
		
	}
	
	
	func configureWithUser(user: FIRUser) {
		self.currentUser = user
		if let email = user.email {
			self.email = email
		}
		self.uid = user.uid
		self.logedIn = true
	}
	
//	func uploadPatientInfo() {
//		if let id = currentUser?.uid {
//			let ref = FIRService.sharedService.refUsers.child(id)
//			let info = ["birthday": currentUser]
//			ref.updateChildValues([], withCompletionBlock: { (error:NSError?, ref:FIRDatabaseReference) in
//				<#code#>
//			})
//		}
//	}
	
	
	
	func logEventCompletedBasicQuestions() {
		
	}
	
	
}