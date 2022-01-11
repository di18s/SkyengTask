//
//  SearchTableCell.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 08.01.2022.
//

import UIKit

final class SearchTableCell: UITableViewCell {
	private var previewImageView: DownloadableImageView!
	private var meaningCountLabel: UILabel!
	private var titleLabel: UILabel!
	private var subtitleLabel: UILabel!
	private var background: UIView!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(_ meaning: SearchWordViewModel) {
		subtitleLabel.isHidden = meaning.subtitle.isEmpty
		subtitleLabel.text = meaning.subtitle
		
		titleLabel.text = meaning.title
		
		meaningCountLabel.isHidden = meaning.childCount <= 1
		meaningCountLabel.text = String(meaning.childCount)
		
		updateExpandedStyle(meaning)
		
		if meaning.previewUrl.contains("/"), let url = URL(string: meaning.previewUrl) {
			previewImageView.setImage(url)
		} else {
			previewImageView.image = UIImage(named: meaning.previewUrl)
		}
	}
	
	func updateExpandedStyle(_ meaning: SearchWordViewModel) {
		background.backgroundColor = meaning.isExpanded ? .gray.withAlphaComponent(0.2) : .white
		
		background.layer.cornerRadius = 15
		switch meaning.cornerClipType {
		case .top:
			background.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		case .middle, .without:
			background.layer.cornerRadius = 0
		case .bottom:
			background.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
		}
	}
}

private extension SearchTableCell {
	func setupUI() {
		selectionStyle = .none
		
		background = UIView()
		background.layer.cornerRadius = 15
		background.translatesAutoresizingMaskIntoConstraints = false
		addSubview(background)
		
		previewImageView = DownloadableImageView()
		previewImageView.translatesAutoresizingMaskIntoConstraints = false
		background.addSubview(previewImageView)
		previewImageView.contentMode = .scaleAspectFill
		previewImageView.layer.cornerRadius = 5
		previewImageView.clipsToBounds = true
		
		meaningCountLabel = UILabel()
		meaningCountLabel.translatesAutoresizingMaskIntoConstraints = false
		previewImageView.addSubview(meaningCountLabel)
		meaningCountLabel.font = .systemFont(ofSize: 20, weight: .bold)
		meaningCountLabel.textColor = .orange
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 3
		stackView.translatesAutoresizingMaskIntoConstraints = false
		background.addSubview(stackView)
		
		titleLabel = UILabel()
		stackView.addArrangedSubview(titleLabel)
		titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
		titleLabel.textColor = .black
		
		subtitleLabel = UILabel()
		stackView.addArrangedSubview(subtitleLabel)
		subtitleLabel.font = .systemFont(ofSize: 15, weight: .regular)
		subtitleLabel.textColor = .gray
		
		NSLayoutConstraint.activate([
			background.topAnchor.constraint(equalTo: topAnchor),
			background.bottomAnchor.constraint(equalTo: bottomAnchor),
			background.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
			background.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
			
			previewImageView.topAnchor.constraint(equalTo: background.topAnchor, constant: 10),
			previewImageView.heightAnchor.constraint(equalToConstant: 40),
			previewImageView.widthAnchor.constraint(equalTo: previewImageView.heightAnchor, multiplier: 1.33),
			previewImageView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10),
			previewImageView.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 15),
			
			meaningCountLabel.centerYAnchor.constraint(equalTo: previewImageView.centerYAnchor),
			meaningCountLabel.centerXAnchor.constraint(equalTo: previewImageView.centerXAnchor),
			
			stackView.centerYAnchor.constraint(equalTo: previewImageView.centerYAnchor),
			stackView.heightAnchor.constraint(lessThanOrEqualTo: previewImageView.heightAnchor),
			stackView.leftAnchor.constraint(equalTo: previewImageView.rightAnchor, constant: 10),
			stackView.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -15)
		])
	}
}
 
