//
//  KHScreening.swift
//  KHHealthCareProj
//
//  Created by Ryan Lu on 6/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import Foundation

import FirebaseDatabase

class KHGeneral :NSObject {
    static let sharedInstance = KHGeneral()
    
    // class varibales
    private var _name: String!
    private var _category: String!
    private var _id: String!
    private var _info: String!
    
    
    
    
    
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
    var info:String {
        return _info
    }
    
    override init() {
        _name = ""
        _category = ""
        _id = ""
        _info = ""
        
    }
    
    init(name: String, category: String, id: String, info: String) {
        
        self._name = name
        self._id = id
        self._category = category
        self._info = info
    }
    
}