//
//  DetailWordPresentableTrait.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 12.01.2022.
//

import Foundation

protocol DetailWordPresentableTraitInput {
	func showDetailWord(by ids: String)
}

protocol DetailWordPresentableTrait where Self: BaseRouter {}

extension DetailWordPresentableTrait where Self: DetailWordPresentableTraitInput {
	func showDetailWord(by ids: String) {
		let vc = DetailWordAssembly.create()
		(vc.moduleInput as? DetailWordModuleInput)?.configWith(ids: ids)
		transitionHandler?.navigationController?.pushViewController(vc, animated: true)
	}
}
