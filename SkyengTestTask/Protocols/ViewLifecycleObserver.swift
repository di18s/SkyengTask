//
//  ViewLifecycleObserver.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 10.01.2022.
//

import Foundation

protocol ViewLifecycleObserver: AnyObject {
	
	func viewAwokeFromNib()
	
	func viewDidLoad()
	
	func viewWillAppear()
	
	func viewDidAppear()
	
	func viewWillDisappear()
	
	func viewDidDisappear()
	
	func viewWillLayoutSubviews()
	
	func viewDidLayoutSubviews()
	
	func didReceiveMemoryWarning()
	
	func becomeActive()
	
	func resignActive()
}

extension ViewLifecycleObserver {
	
	public func viewAwokeFromNib() {}
	
	public func viewDidLoad() {}
	
	public func viewWillAppear() {}
	
	public func viewDidAppear() {}
	
	public func viewWillDisappear() {}
	
	public func viewDidDisappear() {}
	
	public func viewWillLayoutSubviews() {}
	
	public func viewDidLayoutSubviews() {}
	
	public func didReceiveMemoryWarning() {}
	
	func becomeActive() {}
	
	func resignActive() {}
}
