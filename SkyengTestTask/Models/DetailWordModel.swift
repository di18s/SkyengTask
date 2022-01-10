//
//  DetailWordModel.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import Foundation

struct DetailWordModel: Decodable {
	let id: String
	let prefix: String?
	let text: String
	let soundUrl: String
	let images: [ImageUrl]
	let transcription: String
	let translation: MeaningTranslationModel
	let definition: MeaningDefinitionModel
	let examples: [MeaningDefinitionModel]
	let meaningsWithSimilarTranslation: [MeaningsWithSimilarTranslationModel]
}

struct ImageUrl: Decodable {
	let url: String
}

struct MeaningDefinitionModel: Decodable {
	let text: String
	let soundUrl: String
}

struct MeaningsWithSimilarTranslationModel: Decodable {
	let meaningId: Int
	let frequencyPercent: String
	let partOfSpeechAbbreviation: String
	let translation: MeaningTranslationModel
}
