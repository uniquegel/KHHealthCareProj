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

class KHRiskFactor :NSObject {
	static let sharedInstance = KHRiskFactor()
    
    // class varibales 
    private var _name: String!
	private var _category: String!
	private var _id: String!
	private var _subcategory: String!
    
	
	private var _generalList:NSMutableArray?
	private var _cancerList:Dictionary<String,String>?
	private var _vaccineList:Dictionary<String,String>?
    
    private var _isActive: Bool!
    private var _isInVaccine: Bool!
    private var _isInCancer: Bool!
    private var _isInGeneral: Bool!
	
	 
	//GETTERS, SETTERS
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
		return _subcategory
	}
    
    
	var generalList:NSMutableArray? {
		return _generalList
	}
	var cancerList:Dictionary<String,String>? {
		return _cancerList
	}
	var vaccineList:Dictionary<String,String>? {
		return _vaccineList
	}

    var isActive:Bool {
        get{
            return _isActive
        }
        set(ifIsActive){
            _isActive = ifIsActive
        }
        
    }
    
    var isInVaccine:Bool {
        get {
            return _isInVaccine
        }
    }
    
    var isInCancer:Bool {
        get {
            return _isInCancer
        }
    }
    
    var isInGeneral:Bool {
        get {
            return _isInGeneral
        }
    }
    
	override init() {
		_name = ""
		_category = ""
		_id = ""
		_category = ""

	}

	
	init(name: String, category: String, id: String, subcategory: String, generalList:NSMutableArray?, vaccineList: [String:String]?, cancerList: [String:String]?) {
		
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
        
        self._isInVaccine = self._vaccineList != nil ? true:false
        self._isInCancer = self._cancerList != nil ? true:false
        self._isInGeneral = self._generalList != nil ? true:false
//        print("is rf in vaccine? \(self._isInVaccine) , in general? \(self._isInGeneral)")
        
//        if self._vaccineList == nil {
//            self._isInVaccine = false
//        }
        
        self._isActive = false;
		

	}

}