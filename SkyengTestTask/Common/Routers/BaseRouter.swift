//
//  BaseRouter.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import UIKit

class BaseRouter {
	private(set) weak var transitionHandler: UIViewController?
	
	init(transitionHandler: UIViewController) {
		self.transitionHandler = transitionHandler
		
	}
}
