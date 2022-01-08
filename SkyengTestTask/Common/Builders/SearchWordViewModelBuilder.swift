//
//  SearchWordViewModelBuilder.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import Foundation

protocol SearchWordViewModelBuilderType {
	func build(from model: [SearchWordModel]) -> [SearchWordViewModel]
	func buildChildMeanings(from model: [MeaningModel]) -> [SearchWordViewModel]
}

final class SearchWordViewModelBuilder: SearchWordViewModelBuilderType {
	func build(from model: [SearchWordModel]) -> [SearchWordViewModel] {
		return model.map {
			var previewImage: String = ""
			if $0.meanings.startIndex != $0.meanings.endIndex {
				previewImage = "words_stack_icon"
			} else if let img = $0.meanings.first?.previewUrl {
				previewImage = img
			}
			let subtitle = $0.meanings.reduce(into: "") { result, model in
				result += ", " + model.translation.text
			}
			return SearchWordViewModel(
				id: $0.meanings.first?.id ?? $0.id,
				previewUrl: previewImage,
				title: $0.text,
				subtitle: subtitle,
				cornerClipType: .without,
				childCount: $0.meanings.count
			)
		}
	}
	
	func buildChildMeanings(from model: [MeaningModel]) -> [SearchWordViewModel] {
		return model.map {
			.init(id: $0.id,
				  previewUrl: $0.previewUrl,
				  title: $0.translation.text,
				  cornerClipType: .middle,
				  childCount: 0)
		}
	}
}
