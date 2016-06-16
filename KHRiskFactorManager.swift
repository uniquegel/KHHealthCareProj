//
//  KHRiskFactorModel.swift
//  KHHealthCareProj
//
//  Created by Ryan Lu on 6/14/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//
// This is the model that holds all the risk factors

import Foundation
import FirebaseDatabase

@objc
class KHRiskFactorManager: NSObject {
    static let sharedManager = KHRiskFactorManager()
	
	//RISK FACTORS
	private var _allRiskFactors:[KHRiskFactor] = []
	private var _ageRiskFactors:[KHRiskFactor] = []
	private var _MDRiskFactors:[KHRiskFactor] = []
	private var _EFLRiskFactors:[KHRiskFactor] = []
	
	//CATEGORIES
	private var _RFCategories:Dictionary<String,String> = [:]
	private var _RFSubCategories:Dictionary<String,String> = [:]
	
	/** GETTER & SETTER**/
	var allRiskFactors:[KHRiskFactor] {
		return _allRiskFactors
	}
	var ageRiskFactors:[KHRiskFactor] {
		return _ageRiskFactors
	}
	var MDRiskFactors:[KHRiskFactor]  {
		return _MDRiskFactors
	}
	var EFLRiskFactors:[KHRiskFactor] {
		return _EFLRiskFactors
	}
	
	
	override init() {
		
	}
	
	/** DOWNLOAD DATA FUNCS**/
	func downloadAllRiskFactors() {
		let ref = FIRService.sharedService.refRiskfactorGen
		
		ref.observeSingleEventOfType(.Value) { (snapshot:FIRDataSnapshot) in
			if let riskFactors = snapshot.value as? Dictionary<String,AnyObject> {
				for (rfKey,rfValue) in riskFactors {
					
					let rfValueDict = rfValue as! [String:AnyObject]
					
					for (key,value) in rfValueDict {
						print(key)
						print(value)
					}
				}
			}
		}
	}
	
	
	
}