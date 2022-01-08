//
//  SearchWordService.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

protocol SearchWordServiceInput: AnyObject {
	func findWord(_ word: String, completion: @escaping ([SearchWordModel], Error?) -> Void)
}

final class SearchWordService: BaseNetworkService, SearchWordServiceInput {
	init() {
		super.init()
	}
	
	func findWord(_ word: String, completion: @escaping ([SearchWordModel], Error?) -> Void) {
		let request = NetworkRequest.makeRequest(
			with: APIMethod(method: APIMethods.Words.search),
			parameters: [APIKeys.Word.search : word]
		)
		performRequest(request) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let data):
				if let model: [SearchWordModel] = self.mapObject(data) {
					completion(model, nil)
				} else {
					completion([], DataError.invalidData)
				}
			case .error(let error):
				completion([], error)
			}
		}
	}
}
