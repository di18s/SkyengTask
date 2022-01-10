//
//  RemoteImageSourceBuilder.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import Foundation

protocol RemoteImageSourceBuilderType {
	func build(with strUrl: String?, remoteImageSize: RemoteImageSize) -> URL?
	func prepareImageUrl(from string: String) -> String
}

struct RemoteImageSourceBuilder: RemoteImageSourceBuilderType {
	func build(with strUrl: String?, remoteImageSize: RemoteImageSize) -> URL? {
		guard let strUrl = strUrl else { return nil }
		guard var resultStrUrl = prepareImageUrl(from: strUrl).components(separatedBy: "?").first else { return nil }
		resultStrUrl += "?" + remoteImageSize.stringValue
		return URL(string: resultStrUrl)
	}
	
	func prepareImageUrl(from string: String) -> String {
		return string.contains("https:") ? string : "https:" + string
	}
}
