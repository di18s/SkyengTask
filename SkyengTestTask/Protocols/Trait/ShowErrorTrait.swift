//
//  ShowErrorTrait.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import UIKit

protocol ShowErrorTraitInput {
	func showError(message: String, title: String, okTitle: String)
	func showError(message: String, title: String)
	func showError(_ message: String)
}

protocol ShowErrorTrait {
	var transitionHandler: UIViewController? { get }
}

extension ShowErrorTrait {
	func showError(_ message: String) {
		showError(message: message, title: "Error")
	}
	
	func showError(message: String, title: String) {
		showError(message: message, title: title, okTitle: "Ok")
	}
	
	func showError(message: String, title: String, okTitle: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: okTitle, style: .cancel, handler: nil)
		alert.addAction(action)
		transitionHandler?.present(alert, animated: true)
	}
}
