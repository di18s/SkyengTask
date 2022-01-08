//
//  SearchViewController.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import UIKit

protocol SearchViewControllerInput {
	
}

protocol SearchViewControllerOutput: AnyObject {
	func viewDidLoad()
}

final class SearchViewController: UIViewController {
	var presenter: SearchViewControllerOutput!
	
	private var searchBar: UISearchBar!
	private var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.viewDidLoad()
	}
}

extension SearchViewController: SearchViewControllerInput {
	
}

private extension SearchViewController {
	func setupUI() {
		
	}
}
