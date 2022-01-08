//
//  SearchWordViewModel.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import Foundation

enum CornerClipType {
	case top, middle, bottom, without
}

class SearchWordViewModel {
	let id: Int
	let previewUrl: String
	let title: String
	let subtitle: String
	let childCount: Int
	var cornerClipType: CornerClipType
	var isExpanded: Bool
	var isExpandable: Bool {
		return childCount > 1
	}
	
	init(id: Int,
		 previewUrl: String,
		 title: String,
		 subtitle: String = "",
		 cornerClipType: CornerClipType = .without,
		 childCount: Int,
		 isExpanded: Bool = false) {
		self.id = id
		self.previewUrl = previewUrl
		self.title = title
		self.subtitle = subtitle
		self.childCount = childCount
		self.isExpanded = isExpanded
		self.cornerClipType = cornerClipType
	}
}
