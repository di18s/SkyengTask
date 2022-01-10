//
//  SearchModulePresenter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import Foundation

enum SearchModuleTableSection {
	case main, other
}

enum TableInsertionAction {
	case insert, delete
}

enum SearchScreenMessageType {
	case emptyResponse, initial
}

final class SearchModulePresenter {
	private weak var view: SearchViewControllerInput!
	private let interactor: SearchModuleInteractorInput
	private let router: SearchModuleRouterInput
	private let viewModelBuilder: SearchWordViewModelBuilderType
	
	private var viewModel: [SectionViewModel<SearchWordViewModel>] = []
	private let sections: [SearchModuleTableSection] = [.main, .other]
	private var searchText = ""
	private var debounceTimer: Timer?
	
	init(view: SearchViewControllerInput,
		 interactor: SearchModuleInteractorInput,
		 router: SearchModuleRouterInput,
		 viewModelBuilder: SearchWordViewModelBuilderType) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.viewModelBuilder = viewModelBuilder
	}
	
	func makeResultLabelText(by type: SearchScreenMessageType) -> String {
		switch type {
		case .emptyResponse:
			return "Для этого слова нет переводов"
		case .initial:
			return "Ищите перевод слов"
		}
	}
}

//MARK: ViewOutput
extension SearchModulePresenter: SearchViewControllerOutput {
	func viewDidLoad() {
		view.setLoading(false)
		view.updateResultLabel(with: makeResultLabelText(by: .initial))
		view.updateSections(sections)
	}
	
	func meaningDidSelect(by indexPath: IndexPath) {
		let meaning = viewModel[indexPath.section].list[indexPath.row]
		if meaning.isExpandable {
			guard let sourceMeaning = interactor.model.first(where: { $0.id == meaning.parentId }) else { return }
			
			let meaningsViewModel = viewModelBuilder.buildChildMeanings(from: sourceMeaning)
			
			let indexPaths: [IndexPath] = meaningsViewModel.enumerated().map {
				IndexPath(row: indexPath.row + $0.offset + 1, section: indexPath.section)
			}
			
			if meaning.isExpanded {
				guard let first = indexPaths.first?.row,
					  let last = indexPaths.last?.row else { return }
				viewModel[indexPath.section].list.removeSubrange(first...last)
			} else {
				viewModel[indexPath.section].list.insert(contentsOf: meaningsViewModel, at: indexPath.row + 1)
			}
			let action: TableInsertionAction = meaning.isExpanded ? .delete : .insert
			meaning.isExpanded.toggle()
			view.updateView(viewModel)
			view.updateMeanings(by: indexPaths, action: action)
		} else {
			router.showDetailWord(by: String(meaning.id))
		}
	}
	
	func searchTextDidChange(_ text: String) {
		guard text != searchText else { return }
		searchText = text
		debounceTimer?.invalidate()
		debounceTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
			guard let self = self else { return }
			self.view.setLoading(true)
			self.interactor.findWord(text)
		})
	}
}

//MARK: InteractorOutput
extension SearchModulePresenter: SearchModuleInteractorOutput {
	func meaningsReceived(_ model: [SearchWordModel]) {
		view.setLoading(false)
		viewModel = viewModelBuilder.buildSectionViewModel(from: model)
		view.updateView(viewModel)
		view.reloadTable()
		var text = ""
		if model.isEmpty {
			text = makeResultLabelText(by: .emptyResponse)
		}
		view.updateResultLabel(with: text)
	}
	
	func errorReceived(_ errorDescription: String?) {
		view.setLoading(false)
		router.showError(errorDescription ?? ~"DefaultError")
	}
	
}
