//
//  DetailWordInteractor.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import Foundation

protocol DetailWordInteractorInput {
	func getDetailWord(by ids: String)
}

protocol DetailWordInteractorOutput: AnyObject {
	func detailReceived(_ model: [DetailWordModel])
	func errorReceived(_ errorDescription: String?)
}

final class DetailWordInteractor {
	weak var presenter: DetailWordInteractorOutput?
	private let searchService: DetailWordServiceInput
	
	init(searchService: DetailWordServiceInput) {
		self.searchService = searchService
	}
}

extension DetailWordInteractor: DetailWordInteractorInput {
	func getDetailWord(by ids: String) {
		searchService.getDetailWord(by: ids) { [weak self] model, error in
			guard let self = self else { return }
			guard error == nil else { self.presenter?.errorReceived(error?.localizedDescription); return }
			self.presenter?.detailReceived(model)
		}
	}
	
}
