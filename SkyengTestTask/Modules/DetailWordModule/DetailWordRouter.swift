//
//  DetailWordRouter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import UIKit

protocol DetailWordRouterInput: ShowErrorTraitInput {
	func showDetailWord(by ids: String)
}

final class DetailWordRouter: BaseRouter, DetailWordRouterInput, ShowErrorTrait {
	func showDetailWord(by ids: String) {
		let vc = DetailWordAssembly.create()
		(vc.moduleInput as? DetailWordModuleInput)?.configWith(ids: ids)
		transitionHandler?.navigationController?.pushViewController(vc, animated: true)
	}
}
