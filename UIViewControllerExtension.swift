//
//  UIViewControllerExtension.swift
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/11/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	func showAlertView(title: String, message: String?, target: UIViewController) {
		let alert =  UIAlertController(title: title, message: message, preferredStyle: .Alert)
		let OKAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
		alert.addAction(OKAction)
		target.presentViewController(alert, animated: true, completion: nil)
	}
}