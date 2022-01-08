//
//  UITableView+Ext.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 08.01.2022.
//


import UIKit

extension UITableView {
	func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
		let cell: T = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
		return cell
	}
	
	func register(cells: [UITableViewCell.Type]) {
		cells.forEach { cell in
			register(cell.self, forCellReuseIdentifier: String(describing: cell.self))
		}
	}
}

