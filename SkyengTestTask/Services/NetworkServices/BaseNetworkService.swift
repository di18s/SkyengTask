//
//  BaseNetworkService.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

enum Result {
	case success(Data)
	case error(NetworkError)
}

enum DataError: Error {
	case invalidData
	
	var localizedDescription: String {
		switch self {
		case .invalidData:
			return "Failed to parse Words entities from obtained data"
		}
	}
}

enum NetworkError: Error {
	case requestError(code: Int)
	case unspecifiedError
	case emptyResponse
	
	var localizedDescription: String {
		switch self {
		case .requestError(let code):
			return String(format: ~"NetworkErrorRequestError", code)
		case .unspecifiedError:
			return ~"NetworkErrorUnspecifiedError"
		case .emptyResponse:
			return ~"NetworkErrorEmptyResponse"
		}
	}
}

class BaseNetworkService {
	private var session = URLSession(configuration: .default)
	private let queue = DispatchQueue(label: "BaseNetworkServiceQueue")
	
	init(_ sessionConfiguration: URLSessionConfiguration = .default) {
		session = URLSession(configuration: sessionConfiguration)
	}
	
	func performRequest(_ request: URLRequest, completion: @escaping (Result) -> Void) {
		queue.async { [weak self] in
			guard let self = self else { return }
			self.session.dataTask(with: request) { data, response, error in
				DispatchQueue.main.async {
					if error != nil {
						completion(.error(.unspecifiedError))
					} else if let httpResponse = response as? HTTPURLResponse {
						switch httpResponse.statusCode {
						case (400...599):
							completion(.error(.requestError(code: httpResponse.statusCode)))
						default:
							guard let data = data else { completion(.error(.emptyResponse)); return }
							completion(.success(data))
						}
					} else {
						completion(.error(.unspecifiedError))
					}
				}
			}.resume()
		}
	}
	
	func mapObject<T: Decodable>(_ data: Data) -> T? {
		return try? JSONDecoder().decode(T.self, from: data)
	}
}


