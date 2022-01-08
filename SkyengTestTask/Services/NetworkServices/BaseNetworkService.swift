//
//  BaseNetworkService.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

class BaseNetworkService {
	private var session = URLSession(configuration: .default)
	private let queue = DispatchQueue(label: "BaseNetworkServiceQueue")
	
	init(_ sessionConfiguration: URLSessionConfiguration = .default) {
		session = URLSession(configuration: sessionConfiguration)
	}
	
	func performRequest(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
		queue.async { [weak self] in
			guard let self = self else { return }
			self.session.dataTask(with: request, completionHandler: completion).resume()
		}
	}
	
	func mapObject<T: Decodable>(_ data: Data) -> T? {
		return try? JSONDecoder().decode(T.self, from: data)
	}
}


