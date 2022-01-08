//
//  LoadableViewInput.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 08.01.2022.
//

import UIKit

protocol Loader where Self: UIView {
	func startAnimating()
	func stopAnimating()
}

protocol LoadableViewInput: LoadableInput {
	var activityIndicator: Loader! { get }
}

extension LoadableViewInput {
	func setLoading(_ loading: Bool) {
		self.activityIndicator.superview?.bringSubviewToFront(self.activityIndicator)
		loading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
	}
}

extension UIActivityIndicatorView: Loader {}
