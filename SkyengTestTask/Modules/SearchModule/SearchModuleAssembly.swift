//
//  SearchModuleAssembly.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import UIKit

enum SearchModuleAssembly {
	static func create() -> SearchViewController {
		let view = SearchViewController()
		self.injectProperties(in: view)
		return view
	}
	
	private static func injectProperties(in view: SearchViewController) {
		let router = SearchModuleRouter(transitionHandler: view)
		let interactor = SearchModuleInteractor(searchService: NetworkServicesAssembly
													.searchWordService())
		let presenter = SearchModulePresenter(view: view,
											  interactor: interactor,
											  router: router,
											  viewModelBuilder: SearchWordViewModelBuilder())
		view.presenter = presenter
		interactor.presenter = presenter
	}
}
