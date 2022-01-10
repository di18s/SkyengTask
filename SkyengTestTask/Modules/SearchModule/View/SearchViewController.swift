//
//  SearchViewController.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import UIKit

protocol SearchViewControllerInput: LoadableInput {
	func updateSections(_ sections: [SearchModuleTableSection])
	func updateView(_ viewModel: [SectionViewModel<SearchWordViewModel>])
	func updateMeanings(by indexPaths: [IndexPath], action: TableInsertionAction)
	func reloadTable()
	func updateResultLabel(with text: String)
}

protocol SearchViewControllerOutput: ViewLifecycleObserver {
	func meaningDidSelect(by indexPath: IndexPath)
	func searchTextDidChange(_ text: String)
}

//MARK: SearchViewController
final class SearchViewController: BaseViewController, LoadableViewInput {
	var output: SearchViewControllerOutput!
	
	private(set) var activityIndicator: Loader!
	private var searchBar: UISearchBar!
	private var tableView: UITableView!
	private var resultTitleLabel: UILabel!
	
	private var sections: [SearchModuleTableSection] = []
	private var viewModel: [SectionViewModel<SearchWordViewModel>] = []
	
	override func setupView() {
		setupUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		navigationController?.navigationBar.isHidden = false
		
		tabBarController?.tabBar.isHidden = false
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		activityIndicator.center = view.center
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
}

//MARK: SearchViewControllerInput
extension SearchViewController: SearchViewControllerInput {
	func updateResultLabel(with text: String) {
		resultTitleLabel.text = text
	}
	
	func updateSections(_ sections: [SearchModuleTableSection]) {
		self.sections = sections
	}
	
	func updateView(_ viewModel: [SectionViewModel<SearchWordViewModel>]) {
		self.viewModel = viewModel
	}
	
	func updateMeanings(by indexPaths: [IndexPath], action: TableInsertionAction) {
		guard let index = indexPaths.first else { return }
		let indexPath = IndexPath(row: index.row - 1, section: index.section)
		guard let cell = tableView.cellForRow(at: indexPath) as? SearchTableCell else { return }
		
		tableView.performBatchUpdates {
			switch action {
			case .insert:
				tableView.insertRows(at: indexPaths, with: .automatic)
				cell.updateExpandedStyle(viewModel[indexPath.section].list[indexPath.row])
			case .delete:
				tableView.deleteRows(at: indexPaths, with: .automatic)
			}
		} completion: { _ in
			guard action == .delete else { return }
			cell.updateExpandedStyle(self.viewModel[indexPath.section].list[indexPath.row])
		}

	}
	
	func reloadTable() {
		guard sections.isEmpty == false else { tableView.reloadData(); return }
		tableView.performBatchUpdates {
			tableView.reloadSections(IndexSet(0..<sections.count), with: .automatic)
		}
	}
}

//MARK: UITableViewDataSource, UITableViewDataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		switch sections[section] {
		case .main:
			return 5
		case .other:
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		switch sections[section] {
		case .main:
			return 0
		case .other:
			return 30
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard viewModel.indices.contains(section) else { return nil }
		switch sections[section] {
		case .main:
			return nil
		case .other:
			let header = makeHeader()
			header.title.text = viewModel[section].title
			return header.view
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard viewModel.indices.contains(section) else { return 0 }
		return viewModel[section].list.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: SearchTableCell = tableView.dequeue(for: indexPath)
		let meaning = viewModel[indexPath.section].list[indexPath.row]
		cell.configure(meaning)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		output.meaningDidSelect(by: indexPath)
	}
}

//MARK: SearchViewController
extension SearchViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(true, animated: true)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		output.searchTextDidChange(searchText)
	}
	
	func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		guard text != .newline else {
			searchBar.setShowsCancelButton(false, animated: true)
			searchBar.endEditing(true)
			return false
		}
		return true
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		searchBar.setShowsCancelButton(false, animated: true)
		searchBar.endEditing(true)
	}
}

//MARK: private extension
private extension SearchViewController {
	@objc func keyboardWasShown(notification: Notification) {
		let info = notification.userInfo! as NSDictionary
		let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
		let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
		
		tableView?.contentInset = contentInsets
		tableView?.scrollIndicatorInsets = contentInsets
	}
	
	@objc func keyboardWillBeHidden(notification: Notification) {
		let contentInsets = UIEdgeInsets.zero
		tableView?.contentInset = contentInsets
		tableView?.scrollIndicatorInsets = contentInsets
	}
	
	func setupUI() {
		view.backgroundColor = .white
		searchBar = UISearchBar()
		searchBar.searchBarStyle = .minimal
		searchBar.placeholder = ~"SearchBarPlaceholder"
		searchBar.delegate = self
		searchBar.returnKeyType = .done
		navigationItem.titleView = searchBar
		
		tableView = UITableView(frame: .zero, style: .grouped)
		view.addSubview(tableView)
		tableView.rowHeight = 60
		tableView.backgroundColor = .white
		tableView.separatorStyle = .none
		tableView.delegate = self
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(cells: [SearchTableCell.self])
		
		resultTitleLabel = UILabel()
		resultTitleLabel.numberOfLines = 0
		resultTitleLabel.textAlignment = .center
		resultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		resultTitleLabel.font = .systemFont(ofSize: 17)
		resultTitleLabel.textColor = .lightGray
		view.addSubview(resultTitleLabel)
		
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
			
			resultTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			resultTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
			resultTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
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
