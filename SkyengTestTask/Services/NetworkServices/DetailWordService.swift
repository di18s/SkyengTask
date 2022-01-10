//
//  DetailWordService.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import Foundation

protocol DetailWordServiceInput: AnyObject {
	func getDetailWord(by ids: String, completion: @escaping ([DetailWordModel], Error?) -> Void)
}

final class DetailWordService: BaseNetworkService, DetailWordServiceInput {
	init() {
		super.init()
	}
	
	func getDetailWord(by ids: String, completion: @escaping ([DetailWordModel], Error?) -> Void) {
		let request = NetworkRequest.makeRequest(
			with: APIMethod(method: APIMethods.Words.meanings),
			parameters: [APIKeys.Word.ids : ids]
		)
		
		performRequest(request) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let data):
				if let model: [DetailWordModel] = self.mapObject(data) {
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
