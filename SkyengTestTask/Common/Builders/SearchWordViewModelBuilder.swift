//
//  SearchWordViewModelBuilder.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import Foundation

protocol SearchWordViewModelBuilderType {
	func buildSectionViewModel(from model: [SearchWordModel]) -> [SectionViewModel<SearchWordViewModel>]
	func buildMeaningViewModel(from model: [SearchWordModel]) -> [SearchWordViewModel]
	func buildChildMeanings(from model: SearchWordModel) -> [SearchWordViewModel]
}

final class SearchWordViewModelBuilder: SearchWordViewModelBuilderType {
	private let remoteImageSourceBuilder: RemoteImageSourceBuilderType
	
	init(remoteImageSourceBuilder: RemoteImageSourceBuilderType) {
		self.remoteImageSourceBuilder = remoteImageSourceBuilder
	}
	
	func buildSectionViewModel(from model: [SearchWordModel]) -> [SectionViewModel<SearchWordViewModel>] {
		
		let viewModel = buildMeaningViewModel(from: model)
		
		guard viewModel.isEmpty == false,
			  let firstParent = model.first,
			  let firstMeaning = firstParent.meanings.first
		else { return [] }
		
		let sectionMeanings: [SearchWordViewModel] = [
			.init(id: firstMeaning.id,
				  parentId: firstParent.id,
				  previewUrl: remoteImageSourceBuilder.prepareImageUrl(from: firstMeaning.previewUrl),
				  title: firstParent.text,
				  subtitle: firstMeaning.translation.text)
		]
		
		return [
			.init(list: sectionMeanings),
			.init(title: ~"SearchModuleSectionOtherWordsTitle", list: viewModel)
		]
	}
	
	func buildMeaningViewModel(from model: [SearchWordModel]) -> [SearchWordViewModel] {
		return model.map {
			var previewImage: String = ""
			var cornerClipType: CornerClipType = .without
			if $0.meanings.count > 1 {
				previewImage = "words_stack_icon"
				cornerClipType = .top
			} else if let img = $0.meanings.first?.previewUrl {
				previewImage = remoteImageSourceBuilder.prepareImageUrl(from: img)
			}
			let subtitle = $0.meanings.reduce(into: "") { result, model in
				if result.isEmpty {
					result = model.translation.text
				} else {
					result += ", " + model.translation.text
				}
			}
			return SearchWordViewModel(
				id: $0.meanings[0].id,
				parentId: $0.id,
				previewUrl: previewImage,
				title: $0.text,
				subtitle: subtitle,
				cornerClipType: cornerClipType,
				childCount: $0.meanings.count
			)
		}
	}
	
	func buildChildMeanings(from model: SearchWordModel) -> [SearchWordViewModel] {
		let meanings: [SearchWordViewModel] = model.meanings.map {
			return .init(id: $0.id,
						 parentId: model.id,
						 previewUrl: remoteImageSourceBuilder.prepareImageUrl(from: $0.previewUrl),
						 title: $0.translation.text,
						 cornerClipType: .middle,
						 isExpanded: true)
		}
		meanings.last?.cornerClipType = .bottom
		return meanings
	}
}
