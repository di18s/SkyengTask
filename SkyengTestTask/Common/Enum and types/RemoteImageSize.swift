//
//  RemoteImageSize.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import UIKit

enum RemoteImageSize {
	case w640h480
	case custom(CGSize)
	
	var stringValue: String {
		switch self {
		case .w640h480:
			return "w=640&h=480"
		case let .custom(size):
			return "w=\(Int64(size.width))&h=\(Int64(size.height))"
		}
	}
}
