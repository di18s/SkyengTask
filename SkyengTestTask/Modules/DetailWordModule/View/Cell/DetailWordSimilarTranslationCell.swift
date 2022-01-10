//
//  DetailWordSimilarTranslationCell.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import UIKit

final class DetailWordSimilarTranslationCell: UITableViewCell {
	private var frequencyPercentProgress: UIProgressView!
	private var titleLabel: UILabel!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(_ model: DetailWordSimilarTramslationViewModel) {
		titleLabel.text = model.title
		frequencyPercentProgress.progress = model.percent
	}
}

private extension DetailWordSimilarTranslationCell {
	func setupUI() {
		selectionStyle = .none
		let rightArrow = UIImageView()
		rightArrow.translatesAutoresizingMaskIntoConstraints = false
		rightArrow.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
		rightArrow.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
		rightArrow.image = UIImage(named: "right_chevron")
		addSubview(rightArrow)
		
		frequencyPercentProgress = UIProgressView()
		frequencyPercentProgress.layer.cornerRadius = 3
		frequencyPercentProgress.clipsToBounds = true
		frequencyPercentProgress.translatesAutoresizingMaskIntoConstraints = false
		frequencyPercentProgress.trackTintColor = .gray.withAlphaComponent(0.2)
		frequencyPercentProgress.progressTintColor = .orange
		frequencyPercentProgress.transform = CGAffineTransform(rotationAngle: -.pi / 2)
		addSubview(frequencyPercentProgress)
		
		titleLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(titleLabel)
		titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
		titleLabel.textColor = .black
		
		let commonHSideInset: CGFloat = 20
		let commonVSideInset: CGFloat = 10
		let progressWidth: CGFloat = 30
		let progressHeight: CGFloat = 6
		let pogressLeftInset: CGFloat = commonHSideInset - progressWidth / 2 + progressHeight / 2
		let pogressTopInset: CGFloat = commonVSideInset + progressWidth / 2 - progressHeight / 2
		
		NSLayoutConstraint.activate([
			frequencyPercentProgress.topAnchor.constraint(equalTo: topAnchor, constant: pogressTopInset),
			frequencyPercentProgress.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -pogressTopInset),
			frequencyPercentProgress.heightAnchor.constraint(equalToConstant: progressHeight),
			frequencyPercentProgress.widthAnchor.constraint(equalToConstant: progressWidth),
			frequencyPercentProgress.leftAnchor.constraint(equalTo: leftAnchor, constant: pogressLeftInset),
			
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			titleLabel.rightAnchor.constraint(equalTo: rightArrow.leftAnchor, constant: -10),
			titleLabel.leftAnchor.constraint(equalTo: frequencyPercentProgress.rightAnchor, constant: 10),
			
			rightArrow.centerYAnchor.constraint(equalTo: centerYAnchor),
			rightArrow.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
		])
	}
}
