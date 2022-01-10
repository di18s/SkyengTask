//
//  DetailWordController.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 09.01.2022.
//

import UIKit

protocol DetailWordControllerInput: LoadableInput {
	func updateSections(_ sections: [DetailWordSection])
	func updateView(_ viewModel: DetailWordViewModel?)
}

protocol DetailWordControllerOutput: ViewLifecycleObserver {
	func audioSelected(with audioUrl: URL?)
	func didSelectItem(by indexPath: IndexPath)
}

final class DetailWordController: BaseViewController, LoadableViewInput {
	var output: DetailWordControllerOutput!
	
	private(set) var activityIndicator: Loader!
	private var tableView: UITableView!
	private var sections: [DetailWordSection] = []
	private var viewModel: DetailWordViewModel?
	
	override func setupView() {
		setupUI()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		activityIndicator.center = view.center
	}
}

//MARK: DetailWordControllerInput
extension DetailWordController: DetailWordControllerInput {
	func updateSections(_ sections: [DetailWordSection]) {
		self.sections = sections
	}
	
	func updateView(_ viewModel: DetailWordViewModel?) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}

//MARK: UITableViewDataSource, UITableViewDelegate
extension DetailWordController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		switch sections[section] {
		case .mainInfo:
			return 20
		case .wordExample:
			return 30
		case .wordSimlarTranslations:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let viewModel = viewModel else { return nil }
		switch sections[section] {
		case .mainInfo, .wordExample:
			return nil
		case .wordSimlarTranslations:
			let header = makeHeader()
			header.title.text = viewModel.similarTranslationsSection.title
			return header.view
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch sections[section] {
		case .mainInfo, .wordExample:
			return 0
		case .wordSimlarTranslations:
			return viewModel?.similarTranslationsSection.list.isEmpty != false ? 0 : 30
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let viewModel = viewModel else { return 0 }
		switch sections[section] {
		case .mainInfo:
			return 1
		case .wordExample:
			return viewModel.examplesSection.list.count
		case .wordSimlarTranslations:
			return viewModel.similarTranslationsSection.list.count
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let viewModel = viewModel else { return UITableViewCell() }
		switch sections[indexPath.section] {
		case .mainInfo:
			let cell: DetailWordMainInfoCell = tableView.dequeue(for: indexPath)
			cell.configure(viewModel.mainInfoSection.list[indexPath.row])
			return cell
		case .wordExample:
			let model = viewModel.examplesSection.list[indexPath.row]
			let cell: DetailWordExampleCell = tableView.dequeue(for: indexPath)
			cell.configure(model)
			cell.onPlayButtonSelected = { [unowned cell, unowned self] in
				guard let row = tableView.indexPath(for: cell)?.row else { return }
				output.audioSelected(with: viewModel.examplesSection.list[row].soundUrl)
			}
			return cell
		case .wordSimlarTranslations:
			let model = viewModel.similarTranslationsSection.list[indexPath.row]
			let cell: DetailWordSimilarTranslationCell = tableView.dequeue(for: indexPath)
			cell.configure(model)
			return cell
		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		output.didSelectItem(by: indexPath)
	}
}

private extension DetailWordController {
	func setupUI() {
		view.backgroundColor = .white
		
		tableView = UITableView(frame: .zero, style: .grouped)
		view.addSubview(tableView)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.backgroundColor = .white
		tableView.separatorStyle = .none
		tableView.dataSource = self
		tableView.delegate = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(cells: [DetailWordMainInfoCell.self,
								   DetailWordExampleCell.self,
								   DetailWordSimilarTranslationCell.self])
		
		activityIndicator = UIActivityIndicatorView()
		activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		activityIndicator.tintColor = .orange
		view.addSubview(activityIndicator)
		activityIndicator.startAnimating()
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
		])
	}
	
	func makeHeader() -> (view: UIView, title: UILabel) {
		let containerView = UITableViewHeaderFooterView()
		
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 17, weight: .regular)
		label.textColor = .gray
		containerView.addSubview(label)
		
		NSLayoutConstraint.activate([
			label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			label.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
			label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20)
		])
		
		return (view: containerView, title: label)
	}
}
