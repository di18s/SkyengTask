//
//  DownloadableImageView.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import UIKit

class DownloadableImageView: UIImageView {
	private let loaderView = UIActivityIndicatorView()
	private(set) var cache = Cache<URL, Data>(entryLifetime: 6 * 60 * 60)
	private(set) var session = URLSession(configuration: .default)
	
	private var downloadingUrl: URL?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.setupUI()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.loaderView.center = self.center
	}
	
	func setImage(_ source: URL) {
		self.image = nil
		self.loaderView.startAnimating()
		self.downloadingUrl = source
		
		self.getData(at: source) { imgData, imgUrl in
			DispatchQueue.main.async { [weak self] in
				guard let self = self, self.downloadingUrl == imgUrl else { return }
				self.loaderView.stopAnimating()
				self.image = UIImage(data: imgData)
			}
		}
	}
	
	private func setupUI() {
		self.addSubview(self.loaderView)
		self.loaderView.color = .orange
	}
}

extension DownloadableImageView: DownloadableCacheableTrait { }
