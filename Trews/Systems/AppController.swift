//
//  AppController.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

final class AppController: SignInViewControllerDelegate, NewsViewControllerDelegate {
    
    private let client = Client()
    private var window: UIWindow!
    
    // MARK: Public API
    
    func attachInitialUI(with window: UIWindow?) {
        guard let window = window else { return }
        
        window.rootViewController = initRootViewController()
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    // MARK: SignInViewControllerDelegate
    
    func didSignInSuccess(viewController: SignInViewController) {
        window.rootViewController = newsNavigationController()
        window.makeKeyAndVisible()
    }
    
    // MARK: NewsViewControllerDelegate
    
    func didSignOutSuccess(viewController: NewsViewController) {
        window.rootViewController = signInNavigationController()
        window.makeKeyAndVisible()
    }
    
    // MARK: Private API
    
    private func initRootViewController() -> UIViewController {
        if client.isAuthorized {
            return newsNavigationController()
        }
        return signInNavigationController()
    }
    
    private func signInNavigationController() -> UIViewController {
        let signInViewController = SignInViewController(client: client)
        signInViewController.delegate = self
        return NavigationController(rootViewController: signInViewController)
    }
    
    private func newsNavigationController() -> UIViewController {
        let newsViewController = NewsViewController(client: client)
        newsViewController.delegate = self
        return NavigationController(rootViewController: newsViewController)
    }

}
