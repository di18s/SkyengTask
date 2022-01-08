//
//  String+Ext.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import Foundation

extension String {
	static let cachesPath: String? = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
}
