//
//  AppDelegate.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 05.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow()
		window?.frame = UIScreen.main.bounds
		window?.rootViewController = UINavigationController(rootViewController: SearchModuleAssembly.create())
		if #available(iOS 13.0, *) {
			window?.overrideUserInterfaceStyle = .light
		}
		window?.makeKeyAndVisible()
		return true
	}
}

