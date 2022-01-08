//
//  SearchModuleInteractor.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import Foundation

protocol SearchModuleInteractorInput {
	var model: [SearchWordModel] { get }
	
	func findWord(_ word: String)
}

protocol SearchModuleInteractorOutput: AnyObject {
	func meaningsReceived(_ model: [SearchWordModel])
	func errorReceived(_ errorDescription: String?)
}

final class SearchModuleInteractor {
	weak var presenter: SearchModuleInteractorOutput?
	private(set) var model: [SearchWordModel] = []
	private let searchService: SearchWordServiceInput
	
	init(searchService: SearchWordServiceInput) {
		self.searchService = searchService
	}
}

extension SearchModuleInteractor: SearchModuleInteractorInput {
	func findWord(_ word: String) {
		searchService.findWord(word) { [weak self] model, error in
			guard let self = self else { return }
			guard error == nil else { self.presenter?.errorReceived(error?.localizedDescription); return }
			self.model = model
			self.presenter?.meaningsReceived(model)
		}
	}
}
