//
//  APIMethod.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

protocol URLConvertible {
	func asURL() -> URL
}

struct APIMethod: URLConvertible {
	
	let baseURLString: String
	let version: APIVersionType?
	let method: URLPathConvertible?
	
	init(baseURLString: String,
		 version: APIVersionType? = nil,
		 method: URLPathConvertible? = nil) {
		self.baseURLString = baseURLString
		self.version = version
		self.method = method
	}
	
	func asURL() -> URL {
		var urlString = baseURLString
		version.map({ urlString += $0.stringValue() })
		method.map({ urlString += $0.pathString() })
		return URL(string: urlString)!
	}
}

extension APIMethod {
	init(version: APIVersionType? = APIVersion.v1,
		 method: URLPathConvertible?) {
		self = APIMethod(baseURLString: APIConfiguration.shared.baseURLString,
						 version: version,
						 method: method)
	}
}
