//
//  NSAttributedString+Ext.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import UIKit

extension NSAttributedString {
	static func + (l: NSAttributedString, r: NSAttributedString) -> NSAttributedString {
		let mutableAttributedString = NSMutableAttributedString(attributedString: l)
		mutableAttributedString.append(r)
		return mutableAttributedString
	}
	
	static func += (l: inout NSAttributedString, r: NSAttributedString) {
		l = l + r
	}
	
	static func makeAttributes(lineHeight: CGFloat = 0,
							   kern: CGFloat = 0,
							   foregroundColor: UIColor = .black,
							   font: UIFont = .systemFont(ofSize: 17)) -> [NSAttributedString.Key : Any] {
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineHeightMultiple = lineHeight
		return [NSAttributedString.Key.kern: kern,
				NSAttributedString.Key.paragraphStyle: paragraphStyle,
				NSAttributedString.Key.foregroundColor: foregroundColor,
				NSAttributedString.Key.font: font]
		
	}
}
