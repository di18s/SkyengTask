//
//  DetailWordRouter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import Foundation

protocol DetailWordRouterInput: ShowErrorTraitInput, DetailWordPresentableTraitInput {

}

final class DetailWordRouter: BaseRouter, DetailWordRouterInput, ShowErrorTrait, DetailWordPresentableTrait {
	
}
