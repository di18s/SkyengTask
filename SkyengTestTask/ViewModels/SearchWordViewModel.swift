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

class SectionViewModel<T> {
	let title: String
	var list: [T]
	
	init(title: String = "", list: [T]) {
		self.title = title
		self.list = list
	}
}

class SearchWordViewModel {
	let id: Int
	let parentId: Int
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
		 parentId: Int,
		 previewUrl: String,
		 title: String,
		 subtitle: String = "",
		 cornerClipType: CornerClipType = .without,
		 childCount: Int = 0,
		 isExpanded: Bool = false) {
		self.id = id
		self.parentId = parentId
		self.previewUrl = previewUrl
		self.title = title
		self.subtitle = subtitle
		self.childCount = childCount
		self.isExpanded = isExpanded
		self.cornerClipType = cornerClipType
	}
}
