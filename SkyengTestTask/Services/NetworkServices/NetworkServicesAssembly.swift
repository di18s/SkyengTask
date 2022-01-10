//
//  NetworkServicesAssembly.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

enum NetworkServicesAssembly {
	//MARK: SearchWordServiceInput
	private static weak var searchWordServiceContainer: SearchWordServiceInput?
	
	static func searchWordService() -> SearchWordServiceInput {
		if let service = self.searchWordServiceContainer {
			return service
		} else {
			let service = SearchWordService()
			self.searchWordServiceContainer = service
			return service
		}
	}
	
	//MARK: DetailWordServiceInput
	private static weak var detailWordServiceContainer: DetailWordServiceInput?
	
	static func detailWordService() -> DetailWordServiceInput {
		if let service = self.detailWordServiceContainer {
			return service
		} else {
			let service = DetailWordService()
			self.detailWordServiceContainer = service
			return service
		}
	}
}
