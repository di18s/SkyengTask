//
//  NetworkRequest.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

enum HttpMethod: String {
	case get
}

enum ParameterEncoding {
	case body, query
}

final class NetworkRequest {
	static func makeRequest(with apiMethod: URLConvertible,
							httpMethod: HttpMethod = .get,
							parameters: [String: String],
							parameterEncoding: ParameterEncoding = .query) -> URLRequest {
		let url = apiMethod.asURL()
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue
		if parameterEncoding == .body,
		   let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
			request.httpBody = data
		} else {
			request.url = makeUrlWithParams(url: url, params: parameters)
		}
		return request
	}
	
	private static func makeUrlWithParams(url: URL, params: [String: String]) -> URL? {
		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
		components.queryItems = []
		params.forEach { key, value in
			components.queryItems?.append(URLQueryItem(name: key, value: value))
		}
		return components.url
	}
}
