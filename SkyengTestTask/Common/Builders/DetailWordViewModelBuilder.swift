//
//  DetailWordViewModelBuilder.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import Foundation
import UIKit

protocol DetailWordViewModelBuilderType {
	func build(from model: [DetailWordModel]) -> DetailWordViewModel?
}

final class DetailWordViewModelBuilder: DetailWordViewModelBuilderType {
	private let remoteImageSourceBuilder: RemoteImageSourceBuilderType
	
	init(remoteImageSourceBuilder: RemoteImageSourceBuilderType) {
		self.remoteImageSourceBuilder = remoteImageSourceBuilder
	}
	
	func build(from model: [DetailWordModel]) -> DetailWordViewModel? {
		guard let first = model.first else { return nil }
		return DetailWordViewModel(
			mainInfoSection: makeMainInfoSection(first),
			examplesSection: makeExamplesSection(first),
			similarTranslationsSection: makeSimilarTranslationsSection(first)
		)
	}
}

private extension DetailWordViewModelBuilder {
	func makeMainInfoSection(_ model: DetailWordModel) -> SectionViewModel<DetailWordMainInfoViewModel> {
		
		var translationText: NSAttributedString
		if let prefix = model.prefix {
			translationText = (prefix + " " + model.text).addAttributes(font: .systemFont(ofSize: 19, weight: .bold), color: .white)
		} else {
			translationText = model.text.addAttributes(font: .systemFont(ofSize: 19, weight: .bold), color: .white)
		}
		translationText += ("\n" + model.translation.text).addAttributes(font: .systemFont(ofSize: 15), color: .white)
		
		var transcriptionText: String = model.transcription
		if let meaning = model.meaningsWithSimilarTranslation.first {
			transcriptionText += "•" + meaning.partOfSpeechAbbreviation
		}
		
		var imageURL: URL?
		if let imgUrl = model.images.first?.url {
			imageURL = remoteImageSourceBuilder.build(with: imgUrl, remoteImageSize: .w640h480)
		}
		
		let preparedSoundUrlString = remoteImageSourceBuilder.prepareImageUrl(from: model.soundUrl)
		let soundUrl = URL(string: preparedSoundUrlString)
		
		return SectionViewModel(list: [
			.init(imageUrl: imageURL,
				  soundUrl: soundUrl,
				  translationText: translationText,
				  transcriptionText: transcriptionText,
				  definitionText: model.definition.text)
		])
	}
	
	func makeExamplesSection(_ model: DetailWordModel) -> SectionViewModel<DetailWordExampleTextViewModel> {
		
		let examples: [DetailWordExampleTextViewModel] = model.examples.map {
			let preparedSoundUrlString = remoteImageSourceBuilder.prepareImageUrl(from: $0.soundUrl)
			let soundUrl = URL(string: preparedSoundUrlString)
			return .init(imageIcon: "play_icon", title: $0.text, soundUrl: soundUrl)
		}
		return SectionViewModel(list: examples)
	}
	
	func makeSimilarTranslationsSection(_ model: DetailWordModel) -> SectionViewModel<DetailWordSimilarTramslationViewModel> {
		var translations: [DetailWordSimilarTramslationViewModel] = model.meaningsWithSimilarTranslation.map {
			let percent: Float = (Float($0.frequencyPercent) ?? 0) / 100
			return .init(id: String($0.meaningId), percent: percent, title: $0.translation.text)
		}
		translations.removeFirst()
		return SectionViewModel(title: ~"DetailWordSimilarTranslations" ,list: translations)
	}
}
