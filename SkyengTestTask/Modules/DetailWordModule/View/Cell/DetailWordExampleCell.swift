//
//  DetailWordExampleCell.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import UIKit

final class DetailWordExampleCell: UITableViewCell {
	var onPlayButtonSelected: (() -> Void)?
	private var playButton: UIButton!
	private var titleLabel: UILabel!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(_ model: DetailWordExampleTextViewModel) {
		titleLabel.text = model.title
		playButton.setImage(UIImage(named: model.imageIcon), for: .normal)
	}
}

private extension DetailWordExampleCell {
	@objc func playButtonAction() {
		UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
			self.playButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
		} completion: { _ in
			UIView.animate(withDuration: 0.2) {
				self.playButton.transform = CGAffineTransform.identity
			}
		}

		onPlayButtonSelected?()
	}
	
	func setupUI() {
		selectionStyle = .none
		isUserInteractionEnabled = true
		contentView.isUserInteractionEnabled = true
		
		playButton = IncreaseTouchSpaceButton()
		playButton.translatesAutoresizingMaskIntoConstraints = false
		playButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 999), for: .horizontal)
		playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
		addSubview(playButton)
		
		titleLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.font = .systemFont(ofSize: 17)
		titleLabel.textColor = .darkGray
		titleLabel.numberOfLines = 0
		addSubview(titleLabel)
		
		NSLayoutConstraint.activate([
			playButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			playButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
			playButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
			
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			titleLabel.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 20),
			titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
			titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10)
		])
	}
}
