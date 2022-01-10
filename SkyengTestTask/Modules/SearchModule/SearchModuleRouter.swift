//
//  SearchModuleRouter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import UIKit

protocol SearchModuleRouterInput: ShowErrorTraitInput {
	func showDetailWord(by ids: String)
}

final class SearchModuleRouter: BaseRouter, SearchModuleRouterInput, ShowErrorTrait {
	func showDetailWord(by ids: String) {
		let vc = DetailWordAssembly.create()
		(vc.moduleInput as? DetailWordModuleInput)?.configWith(ids: ids)
		transitionHandler?.navigationController?.pushViewController(vc, animated: true)
	}
}
