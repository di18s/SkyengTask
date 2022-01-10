//
//  BaseViewController.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import UIKit

class BaseViewController: UIViewController {
		
	var moduleInput: AnyObject?
	
	lazy var lifecycleObserver: ViewLifecycleObserver? = {
		let mirror = Mirror(reflecting: self)
		return mirror.find(element: "output") as? ViewLifecycleObserver ?? mirror.find(element: "moduleInput") as? ViewLifecycleObserver
	}()
	
	deinit {
		print("☠️ BaseViewController")
	}
	
	override final func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(becomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(resignActive), name: UIApplication.willResignActiveNotification, object: nil)
		setupView()
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.barTintColor = .white
		navigationController?.navigationBar.tintColor = .black
		lifecycleObserver?.viewDidLoad()
	}
	
	func setupView() {
		
	}
	
	@objc func becomeActive() {
		lifecycleObserver?.becomeActive()
	}
	
	@objc func resignActive() {
		lifecycleObserver?.resignActive()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		lifecycleObserver?.viewWillAppear()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		lifecycleObserver?.viewDidAppear()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		lifecycleObserver?.viewWillDisappear()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		lifecycleObserver?.viewDidDisappear()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		lifecycleObserver?.viewWillLayoutSubviews()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		lifecycleObserver?.viewDidLayoutSubviews()
	}
}

