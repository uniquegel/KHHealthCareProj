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


class KHRiskFactorManagerSwift: NSObject {
    static let sharedManager = KHRiskFactorManagerSwift()
	
	//MARK: - Properties
	private var _allRiskFactors:[KHRiskFactor] = []
	private var _ageRiskFactors:[KHRiskFactor] = []
	private var _MDRiskFactors:[KHRiskFactor] = []
	private var _EFLRiskFactors:[KHRiskFactor] = []
	
	//TODO: Parse and save categories
	private var _RFCategories:Dictionary<String,String> = [:]
	private var _RFSubCategories:Dictionary<String,String> = [:]
	
	//MARK: - GETTER & SETTER
	var allRiskFactors:[KHRiskFactor] {
		get {return _allRiskFactors}
	}
	var ageRiskFactors:[KHRiskFactor] {
		get {return _ageRiskFactors}
	}
	var MDRiskFactors:[KHRiskFactor]  {
		get {return _MDRiskFactors}
	}
	var EFLRiskFactors:[KHRiskFactor] {
		get {
			return _EFLRiskFactors
		}
	}
	
	//MARK: - INIT
	override init() {
		
	}
	
	// MARK: - DOWNLOAD DATA FUNCS
	func downloadAllRiskFactors( completion:(completed:Bool) -> Void){
		let ref = FIRService.sharedService.refBase
	
		ref.observeSingleEventOfType(.Value) { (snapshot:FIRDataSnapshot) in
			if let base = snapshot.value as? Dictionary<String, AnyObject> {
                
                print("base: \(base)")
                let rfDict = base["riskfactors-general"]
//                print("rfdict: \(rfDict)")
                let cateDict = base["rf-categories"]
                let subCateDict = base["rf-sub-categories"]
                let gsDict = base["general screening"] as! [String:AnyObject]
                let gsCateDict = base["general screening-categories"]
                
                for (rfKey,rfValue) in rfDict as! [String:AnyObject] {
					
//                    print("riskfactor key: \(rfKey) , value: \(rfValue)")
					let rfValueDict = rfValue as! [String:AnyObject]
                    
                    
                    //get name
					
					let name = rfValueDict["name"] as! String
                    
                    //get id
					let id = rfValueDict["id"] as! String
                    
                    //get category
					let categoryIndex = rfValueDict["category"] as! String
                    var category:String = ""
                    for (cateKey, cateValue) in cateDict as! [String:String] {
//                        print("cate key and cate value: \(cateKey) , \(cateValue)")
                        if (categoryIndex == cateKey ) {
                            category = cateValue
                        }
                    }
//                    print("done getting category")
                    
                    //get sub-category
					let subcatIndex = rfValueDict["sub-category"] as! String
                    var subCate:String = ""
//                    print("here: \(subCateDict)")
                    for (subCateKey, subCateValue) in subCateDict as! [String:AnyObject] {
//                        print("subcate key and subcate value: \(subCateKey), \(subCateValue)")
                        
                        if (subcatIndex == subCateKey ) {
                            let subCateValueDict = subCateValue as! [String:String]
                            subCate = subCateValueDict["name"]!
                            
                        }
                    }
//					print("done getting subcategory")
                    
                    //get general list
					var general_list:[String:String]?
					if let list = rfValueDict["general-list"] as? [String:AnyObject] {
						general_list = self.parseListDict(list, listDefDict:gsDict)
					}
                    print("general list for rf: \(name), list: \(general_list)")
                    
					
                    //get vaccine list
					var vaccine_list:[String:String]?
					if let list = rfValueDict["vaccine-list"] as? [String:AnyObject] {
						vaccine_list = self.parseListDict(list, listDefDict: gsDict)
					}
					
                    //get cancer list
                    
                    
                    
                    //declare riskfactor
//					let riskfactor = KHRiskFactor(name: name, category: category, id: id, subcategory: subCate, generalList: general_list, vaccineList: vaccine_list, cancerList: nil)
                    
                    
                    //add riskfactor to list
//					self._allRiskFactors.append(riskfactor)
					
	
                
				}
                
                
				
//                print("all riskfactors added: \(self._allRiskFactors.count)")
//                print("category one (efl): \(self._EFLRiskFactors.count)")
//                for rf in self._allRiskFactors {
//                    print("rf name: \(rf.name)")
//                    print("rf category: \(rf.category)")
//                    print("rf id: \(rf.id)")
//                    print("rf sub-category: \(rf.subcategory)")
//                    print("general dict: \(rf.generalList)")
//                    print("vaccine dict: \(rf.vaccineList)")
//                    print("-------------------------------")
//                }
//                for i in 1 ..< self._EFLRiskFactors.count {
//                    self._EFLRiskFactors
//                }
				completion(completed: true)
                
				
			}
		}
	}
	
	//MARK:  - Helper Functions
    private func parseListDict(valueDict:[String:AnyObject], listDefDict:[String:AnyObject]) -> [String:String] {
		var listDict:[String:String] = [:]
		/* var name
        var category
        var info
        var id =
        var value = */
        
        
		for (key,value) in valueDict {
            //for key index for definition
            /* for (defKey, defValue) in listDefDict {
//                let defVaueDict =
                if key == defKey {
                    let name = defValue["name"] as! String
                    let category = defValue["category"] as! String
                    let info = defValue["info"] as! String
                    let id = defValue["id"] as! String
                    let screening = KHScreening(name: name, category: category, id: id, info: info)
                    listDict[
                }
            } */
            
            
            //get value for that index
			guard let dict = value as? [String:String], let val = dict["value"]  else {
				continue
			}
			
            
            
            
			listDict[key] = val
		}

		return listDict
	}

	
	
}