//
//  DetailWordMainInfoCell.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import UIKit

final class DetailWordMainInfoCell: UITableViewCell {
	private var previewImageView: DownloadableImageView!
	private var translationLabel: UILabel!
	private var transcriptionLabel: UILabel!
	private var definitionLabel: UILabel!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(_ model: DetailWordMainInfoViewModel) {
		if let url = model.imageUrl {
			previewImageView.setImage(url)
		}
		translationLabel.attributedText = model.translationText
		transcriptionLabel.text = model.transcriptionText
		definitionLabel.text = model.definitionText
	}
}

private extension DetailWordMainInfoCell {
	func setupUI() {
		selectionStyle = .none

		previewImageView = DownloadableImageView()
		previewImageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(previewImageView)
		previewImageView.contentMode = .scaleAspectFill
		previewImageView.layer.cornerRadius = 15
		previewImageView.clipsToBounds = true
		
		let background = UIView()
		background.backgroundColor = UIColor(red: 31 / 255, green: 117 / 255, blue: 254 / 255, alpha: 1)
		background.translatesAutoresizingMaskIntoConstraints = false
		previewImageView.addSubview(background)
		
		translationLabel = UILabel()
		translationLabel.numberOfLines = 0
		background.addSubview(translationLabel)
		translationLabel.textColor = .white
		translationLabel.translatesAutoresizingMaskIntoConstraints = false
		
		transcriptionLabel = UILabel()
		transcriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(transcriptionLabel)
		transcriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
		transcriptionLabel.textColor = .black
		
		definitionLabel = UILabel()
		definitionLabel.numberOfLines = 0
		definitionLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(definitionLabel)
		definitionLabel.font = .systemFont(ofSize: 15, weight: .regular)
		definitionLabel.textColor = .black
		
		NSLayoutConstraint.activate([
			previewImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			previewImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
			previewImageView.heightAnchor.constraint(equalTo: previewImageView.widthAnchor, multiplier: 0.75),
			previewImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			
			background.bottomAnchor.constraint(equalTo: previewImageView.bottomAnchor),
			background.centerXAnchor.constraint(equalTo: previewImageView.centerXAnchor),
			background.widthAnchor.constraint(equalTo: previewImageView.widthAnchor),
			background.heightAnchor.constraint(equalTo: translationLabel.heightAnchor, constant: 20),
			
			translationLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10),
			translationLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 10),
			translationLabel.rightAnchor.constraint(equalTo: background.rightAnchor),
			translationLabel.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 15),
			
			transcriptionLabel.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 20),
			transcriptionLabel.leftAnchor.constraint(equalTo: previewImageView.leftAnchor),
			transcriptionLabel.rightAnchor.constraint(equalTo: previewImageView.rightAnchor),
			
			definitionLabel.topAnchor.constraint(equalTo: transcriptionLabel.bottomAnchor, constant: 20),
			definitionLabel.leftAnchor.constraint(equalTo: previewImageView.leftAnchor),
			definitionLabel.rightAnchor.constraint(equalTo: previewImageView.rightAnchor),
			definitionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
		])
	}
}
