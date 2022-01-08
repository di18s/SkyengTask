//
//  APIMethods.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

protocol URLPathConvertible {
	func pathString() -> String
}

enum APIMethods {
	enum Words: URLPathConvertible {
		case search
		
		func pathString() -> String {
			switch self {
			case .search:
				return "/words/search"
			}
		}
	}
}
