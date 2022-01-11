//
//  DetailWordPresenter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import Foundation

protocol DetailWordModuleInput {
	func configWith(ids: String)
}

enum DetailWordSection {
	case mainInfo, wordExample, wordSimlarTranslations
}

final class DetailWordPresenter: DetailWordModuleInput {
	private weak var view: DetailWordControllerInput!
	private let interactor: DetailWordInteractorInput
	private let router: DetailWordRouterInput
	private let audioPlayer: AudioPlayerInput
	private let viewModelBuilder: DetailWordViewModelBuilderType
	private var viewModel: DetailWordViewModel?
	private var ids: String?
	private let sections: [DetailWordSection] = [.mainInfo, .wordExample, .wordSimlarTranslations]
	private var isPlayableMainSound = false
	
	init(view: DetailWordControllerInput,
		 interactor: DetailWordInteractorInput,
		 router: DetailWordRouterInput,
		 viewModelBuilder: DetailWordViewModelBuilderType,
		 audioPlayer: AudioPlayerInput) {
		self.view = view
		self.interactor = interactor
		self.router = router
		self.viewModelBuilder = viewModelBuilder
		self.audioPlayer = audioPlayer
	}
	
	func configWith(ids: String) {
		self.ids = ids
	}
}

//MARK: view output
extension DetailWordPresenter: DetailWordControllerOutput {
	func viewDidLoad() {
		guard let ids = ids else { return }
		interactor.getDetailWord(by: ids)
	}
	
	func viewDidAppear() {
		guard isPlayableMainSound == false,
			  let soundUrl = viewModel?.mainInfoSection.list.first?.soundUrl else { return }
		isPlayableMainSound = true
		audioPlayer.playSound(by: soundUrl)
	}
	
	func didSelectItem(by indexPath: IndexPath) {
		guard let viewModel = viewModel else { return }
		switch sections[indexPath.section] {
		case .mainInfo:
			audioSelected(with: viewModel.mainInfoSection.list.first?.soundUrl)
		case .wordExample:
			audioSelected(with: viewModel.examplesSection.list[indexPath.row].soundUrl)
		case .wordSimlarTranslations:
			let id = viewModel.similarTranslationsSection.list[indexPath.row].id
			router.showDetailWord(by: id)
		}
	}
	
	func audioSelected(with audioUrl: URL?) {
		audioPlayer.playSound(by: audioUrl)
	}
}

//MARK: Interactor Output
extension DetailWordPresenter: DetailWordInteractorOutput {
	func detailReceived(_ model: [DetailWordModel]) {
		view.setLoading(false)
		view.updateSections(sections)
		viewModel = viewModelBuilder.build(from: model)
		view.updateView(viewModel)
	}
	
	func errorReceived(_ errorDescription: String?) {
		view.setLoading(false)
		router.showError(errorDescription)
	}
}
