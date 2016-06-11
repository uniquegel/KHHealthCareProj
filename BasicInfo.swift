//
//  BasicInfo.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/10/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import Foundation
@objc
class BasicInfo :NSObject {
	
	private var _firstName:String!
	private var _lastName:String!
	private var _gender:String!
	private var _birthday:NSDate!
	private var _birthdayString:String!
	private var _ethnicity:String!
	private var _age:Int!
	
	var firstName:String {
		return _firstName
	}
	var lastName:String {
		return _lastName
	}
	var gender:String{
		return _gender
	}
	var birthday: NSDate {
		return _birthday
	}
	var birthdayString:String {
		return _birthdayString
	}
	var ethnicity:String {
		return _ethnicity
	}
	var age:Int {
		return _age
	}
	
	 override init() {
		_firstName = ""
		_lastName = ""
		_gender = ""
		_birthdayString = ""
		_birthday = NSDate(timeIntervalSince1970:0)
		_ethnicity = ""
	}
	
	internal init(firstName: String, lastName: String, gender: String,birthday: NSDate, eth: String, age: Int) {
		self._firstName = firstName
		self._lastName = lastName
		self._gender = gender
		self._birthday = birthday
		self._ethnicity = eth
		self._age = age
		
		//parse the nsdate object into a string
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		self._birthdayString = dateFormatter.stringFromDate(birthday)
	}
	
	
	
	
	
	
}