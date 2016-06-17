//
//  RiskFactor.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/11/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//
// This is the "Risk Factor" class, this class declares risk factors

import Foundation
import FirebaseDatabase

class KHRiskFactor {
	static let sharedInstance = KHRiskFactor()
    
    // class varibales 
    private var _name: String!
	private var _category: String!
	private var _id: String!
	private var _subcategory: String!
	
	private var _generalList:Dictionary<String,String>?
	private var _cancerList:Dictionary<String,String>?
	private var _vaccineList:Dictionary<String,String>?
	
	
	//GETTERS & SETTERS
	var name: String {
		return _name
	}
	var category: String {
		return _category
	}
	var id:String {
		return _id
	}
	var subcategory:String {
		return _category
	}
	var generalList:Dictionary<String,String>? {
		return _generalList
	}
	var cancerList:Dictionary<String,String>? {
		return _cancerList
	}
	var vaccineList:Dictionary<String,String>? {
		return _vaccineList
	}

	init() {
		_name = ""
		_category = ""
		_id = ""
		_category = ""

	}
	
	init(name: String, category: String, id: String, subcategory: String, generalList:[String:String]?, vaccineList: [String:String]?, cancerList: [String:String]?) {
		
		self._name = name
		self._id = id
		self._category = category
		self._subcategory = subcategory
		if let generalList = generalList {
			self._generalList = generalList
		}
		if let cancerList = cancerList {
			self._cancerList = cancerList
		}
		if let vaccineList = vaccineList {
			self._vaccineList = vaccineList
		}
		

	}
	
	
	
	
	
	
	func downloadRiskFactors() {
		let riskRef = FIRService.sharedService.refRiskfactorGen
//		riskRef.child("rf1").key
		
		riskRef.observeSingleEventOfType(.Value) { (snapshot:FIRDataSnapshot) in
			guard let postDict = snapshot.value as? [String:AnyObject] else {
				print("download riskfactors-general failed")
				return
			}
			
			for (riskKey, riskValue) in postDict  {
				
				//get the general list keys and values
				if let genList = riskValue["general-list"] as? [String:AnyObject] {
					// whole json list of general-list
					print(genList)
				
					for (key,value) in genList {
						// e.g. gen13
						print(key)
						
						if let val = value as? [String:AnyObject] {
							print(val["value"]!)
						}
					}
				}
			}
		}
        
        let genScrRef = FIRService.sharedService.refGeneralScreening
        
        genScrRef.observeSingleEventOfType(.Value, withBlock: {snapshot in
            
            let postDict = snapshot.value
            print("about to print post dict \(postDict)")
            
        })
        
        
        
        
	}
	
	
	
	
	
}