//
//  SearchModuleRouter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import Foundation

protocol SearchModuleRouterInput: ShowErrorTraitInput, DetailWordPresentableTraitInput {

}

final class SearchModuleRouter: BaseRouter, SearchModuleRouterInput, ShowErrorTrait, DetailWordPresentableTrait {

}
