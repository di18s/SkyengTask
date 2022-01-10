//
//  DetailWordViewModel.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import Foundation

struct DetailWordViewModel {
	let mainInfoSection: SectionViewModel<DetailWordMainInfoViewModel>
	let examplesSection: SectionViewModel<DetailWordExampleTextViewModel>
	let similarTranslationsSection: SectionViewModel<DetailWordSimilarTramslationViewModel>
}

struct DetailWordMainInfoViewModel {
	let imageUrl: URL?
	let soundUrl: URL?
	let translationText: NSAttributedString
	let transcriptionText: String
	let definitionText: String
}

struct DetailWordExampleTextViewModel {
	let imageIcon: String
	let title: String
	let soundUrl: URL?
}

struct DetailWordSimilarTramslationViewModel {
	let id: String
	let percent: Float
	let title: String
}
