//
//  Mirror+Ext.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import Foundation

extension Mirror {
	func find(element: String) -> Any? {
		for (label, value) in children where label == element {
			return value
		}
		
		if let superMirror = superclassMirror {
			return superMirror.find(element: element)
		}
		
		return nil
	}
}
