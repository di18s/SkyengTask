//
//  SearchWordModel.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 06.01.2022.
//

import Foundation

struct SearchWordModel: Decodable {
	let id: Int
	let text: String
	let meanings: [MeaningModel]
}

struct MeaningModel: Decodable {
	let id: Int
	let partOfSpeechCode: String
	let translation: MeaningTranslationModel
	let previewUrl: String
	let imageUrl: String
	let transcription: String
	let soundUrl: String
}

struct MeaningTranslationModel: Decodable {
	let text: String
	let note: String?
}

