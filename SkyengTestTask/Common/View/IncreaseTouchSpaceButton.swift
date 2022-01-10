//
//  IncreaseTouchSpaceButton.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import UIKit

class IncreaseTouchSpaceButton: UIButton {
	let increaseInsets: UIEdgeInsets
	
	init(top: CGFloat = 10, left: CGFloat = 10, bottom: CGFloat = 10, right: CGFloat = 10) {
		self.increaseInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		let insets = UIEdgeInsets(top: -increaseInsets.top, left:  -increaseInsets.left, bottom:  -increaseInsets.bottom, right:  -increaseInsets.right)
		return bounds.inset(by: insets).contains(point)
	}
}
