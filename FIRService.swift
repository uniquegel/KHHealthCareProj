//
//  FIRService.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/9/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FIRService: NSObject {
	static let sharedService = FIRService()
	
	var refBase = FIRDatabase.database().reference()
	var refUsers = FIRDatabase.database().reference().child("users")
//	var refCancers = FIRDatabase.database().reference().child("cancers")
	var refVaccines = FIRDatabase.database().reference().child("vaccines")
	var refRiskfactorGen = FIRDatabase.database().reference().child("riskfactors-general")
	
}