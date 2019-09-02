//
//  AppDelegate.swift
//  Trews
//
//  Created by Nguyen Duc on 2/9/19.
//  Copyright © 2019 Nguyen Duc. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private let appController = AppController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create new window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Attach initial UI
        appController.attachInitialUI(with: window)
        
        // Use Alamofire status bar network activity helper
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        return true
    }

}
