//
//  String+Ext.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import UIKit

extension String {
	/// "\n"
	static let newline = "\n"
}

extension String {
	func addAttributes(font: UIFont? = nil,
					   color: UIColor? = .black,
					   _ attr: [NSAttributedString.Key : Any] = [:]) -> NSMutableAttributedString {
		let attributedString = NSMutableAttributedString(string: self)
		var attributes = attr
		if let font = font {
			attributes[.font] = font
		}
		attributes[.foregroundColor] = color
		if let color = attr[.foregroundColor] {
			attributes[.foregroundColor] = color
		}
		attributedString.addAttributes(attributes, range: NSRange(location: 0, length: self.utf16.count))
		return attributedString
	}
}
