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
		return _subcategory
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

	override init() {
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

}