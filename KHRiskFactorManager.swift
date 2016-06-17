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
	internal var MDRiskFactors:[KHRiskFactor]  {
		return _MDRiskFactors
	}
	internal var EFLRiskFactors:[KHRiskFactor] {
		return _EFLRiskFactors
	}
	
	
	override init() {
		
	}
	
	/** DOWNLOAD DATA FUNCS**/
	func downloadAllRiskFactors( completion:(completed:Bool) -> Void){
		let ref = FIRService.sharedService.refRiskfactorGen
	
		ref.observeSingleEventOfType(.Value) { (snapshot:FIRDataSnapshot) in
			if let riskFactors = snapshot.value as? Dictionary<String,AnyObject> {

				for (rfKey,rfValue) in riskFactors {
					
					let rfValueDict = rfValue as! [String:AnyObject]
					
					let name = rfValueDict["name"] as! String
					let id = rfValueDict["id"] as! String
					let category = rfValueDict["category"] as! String
					let subcat = rfValueDict["sub-category"] as! String
					
					var general_list:[String:String]?
					if let list = rfValueDict["general-list"] as? [String:AnyObject] {
						general_list = self.parseGeneralListDict(list)
					}
					
					var vaccine_list:[String:String]?
					if let list = rfValueDict["vaccine-list"] as? [String:AnyObject] {
						vaccine_list = self.parseVaccineListDict(list)
					}
					
					let riskfactor = KHRiskFactor(name: name, category: category, id: id, subcategory: subcat, generalList: general_list, vaccineList: vaccine_list, cancerList: nil)
					
					self._allRiskFactors.append(riskfactor)
					
					//append the risk factor to the list seperated by categories
					switch riskfactor.category {
					case "rf-ct1":
						self._EFLRiskFactors.append(riskfactor)
						break
					case "rf-ct2":
						self._MDRiskFactors.append(riskfactor)
						break
					case "rf-ct3":
						self._ageRiskFactors.append(riskfactor)
						break
					default:
						break
					}
					
				}
				
				completion(completed: true)
				
			}
		}
	}
	
	//helper function to parse the general list
	func parseGeneralListDict(valueDict:[String:AnyObject]) -> [String:String] {
		var generalDict:[String:String] = [:]
		
		for (key,value) in valueDict {
			guard let dict = value as? [String:String], let val = dict["value"]  else {
				continue
			}
			
			generalDict[key] = val
		}

		return generalDict
	}
	
	func parseVaccineListDict(valueDict:[String:AnyObject]) -> [String:String] {
		var vacDict:[String:String] = [:]
		
		for (key,value) in valueDict {
			guard let dict = value as? [String:String], let val = dict["value"]  else {
				continue
			}
			vacDict.updateValue(val, forKey: key)
		}
		
		print(vacDict)
		
		return vacDict
	}
	
	
}