//
//  DetailWordAssembly.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import UIKit

enum DetailWordAssembly {
	static func create() -> DetailWordController {
		let view = DetailWordController()
		self.injectProperties(in: view)
		return view
	}
	
	private static func injectProperties(in view: DetailWordController) {
		let router = DetailWordRouter(transitionHandler: view)
		let interactor = DetailWordInteractor(searchService: NetworkServicesAssembly.detailWordService())
		let presenter = DetailWordPresenter(
			view: view,
			interactor: interactor,
			router: router,
			viewModelBuilder: DetailWordViewModelBuilder(remoteImageSourceBuilder: RemoteImageSourceBuilder()),
			audioPlayer:  AudioPlayer()
		)
		view.output = presenter
		view.moduleInput = presenter
		interactor.presenter = presenter
	}
}
