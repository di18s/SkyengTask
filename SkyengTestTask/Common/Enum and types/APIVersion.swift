//
//  APIVersion.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

protocol APIVersionType {
	func stringValue() -> String
}

enum APIVersion: String, APIVersionType {
	case v1
	
	func stringValue() -> String {
		return self.rawValue
	}
}
