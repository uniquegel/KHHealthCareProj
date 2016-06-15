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

class KHRiskFactor: NSObject {
    
    
    // class varibales 
    private var _name: String!
    private var _type: String!
    private var _isActive: Bool!
    private var _cancerRFList
    private var _vaccineRFList
    
    
    
	static let sharedInstance = RiskFactor()
	
	
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