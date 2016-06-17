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
	internal var allRiskFactors:[KHRiskFactor] {
		return _allRiskFactors
	}
	internal var ageRiskFactors:[KHRiskFactor] {
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
	func downloadAllRiskFactors( completion:(completed:Bool) -> Void){
		let ref = FIRService.sharedService.refRiskfactorGen
	
		ref.observeSingleEventOfType(.Value) { (snapshot:FIRDataSnapshot) in
			if let riskFactors = snapshot.value as? Dictionary<String,AnyObject> {
				var count = 0;
				print(riskFactors.count)
				for (rfKey,rfValue) in riskFactors {
					
					let rfValueDict = rfValue as! [String:AnyObject]
					
					let name = rfValueDict["name"] as! String
					let id = rfValueDict["id"] as! String
					let category = rfValueDict["category"] as! String
					let subcat = rfValueDict["sub-category"] as! String
					print(name,id,category, subcat)
					
					let riskfactor = KHRiskFactor(name: name, category: category, id: id, subcategory: subcat, generalList: nil, vaccineList: nil, cancerList: nil)
					
					self._allRiskFactors.append(riskfactor)
					
					count += 1
					
					if (count >= riskFactors.count) {
						completion(completed: true)
					}
					
				}
			}
		}
	}
	
	
	
}