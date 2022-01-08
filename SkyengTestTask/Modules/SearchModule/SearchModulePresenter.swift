//
//  SearchModulePresenter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import Foundation

final class SearchModulePresenter {
	private let view: SearchViewControllerInput
	private let interactor: SearchModuleInteractorInput
	private let router: SearchModuleRouterInput
	private let viewModelBuilder: SearchWordViewModelBuilderType
	
	private var viewModel: [SearchWordViewModel] = []
	
	init(view: SearchViewControllerInput,
		 interactor: SearchModuleInteractorInput,
		 router: SearchModuleRouterInput,
		 viewModelBuilder: SearchWordViewModelBuilderType) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.viewModelBuilder = viewModelBuilder
	}
}

//MARK: ViewOutput
extension SearchModulePresenter: SearchViewControllerOutput {
	func viewDidLoad() {
		interactor.findWord("find")
	}
	
	func meaningDidSelect(by index: IndexPath) {
		
	}
}

//MARK: InteractorOutput
extension SearchModulePresenter: SearchModuleInteractorOutput {
	func meaningsReceived(_ model: [SearchWordModel]) {
		viewModel = viewModelBuilder.build(from: model)
	}
	
	func errorReceived() {
		router.showError("Some went wrong")
	}
	
}
