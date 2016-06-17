//
//  constants.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/10/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import Foundation


/* FIREBASE KEYS */
let KEY_FIR_BASIC_INF = "basic_info"
let KEY_FIR_USERNAME = "username"
let KEY_FIR_USER_ID = "userid"
let KEY_FIR_USER_EMAIL = "email"
let KEY_FIR_PROVIDER = "provider"

//let name = rfValueDict["name"] as! String
//let id = rfValueDict["id"] as! String
//let category = rfValueDict["category"] as! String
//let subcat = rfValueDict["sub-category"] as! String
//
//var general_list:[String:String]?
//if let list = rfValueDict["general-list"] as? [String:AnyObject] {
//	general_list = self.parseGeneralListDict(list)
//}
//
//var vaccine_list:[String:String]?
//if let list = rfValueDict["vaccine-list"] as? [String:AnyObject] {
//	vaccine_list = self.parseVaccineListDict(list)
//}


let KEY_FIR_RISKFACTOR_NAME = "name"
let KEY_FIR_RISKFACTOR_ID = "id"
let KEY_FIR_RISKFACTOR_CATEGORY = "category"
let KEY_FIR_RISKFACTOR_SUB_CATEGORY = "sub-category"
let KEY_FIR_RISKFACTOR_GENERAL_LIST = "general-list"
let KEY_FIR_RISKFACTOR_VACCINE_LIST = "vaccine-list"

/** SEGUE IDs **/
let SEGUE_SIGNIN_TO_HOME = "signInToHomePageSegue"
let SEGUE_SIGNIN_TO_SIGNUP = "signIntoSignUpSegue"
