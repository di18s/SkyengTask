//
//  DownloadableCacheableTrait.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import Foundation

protocol DownloadableCacheableTrait {
	var cache: Cache<URL, Data> { get }
	var session: URLSession { get }
}

extension DownloadableCacheableTrait {
	func getData(at url: URL, completion: @escaping (Data, URL) -> Void) {
		if let data = self.cache[url] {
			completion(data, url)
			return
		}
		session.dataTask(with: url) { (data, response, _) in
			guard let data = data, let url = response?.url else { return }
			self.cache[url] = data
			completion(data, url)
		}.resume()
	}
}
