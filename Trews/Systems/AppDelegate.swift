//
//  AppDelegate.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
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
        
        // Use app primary color for system components
        window?.tintColor = Constants.Color.primary.color
        
        return true
    }

}
