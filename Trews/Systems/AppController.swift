//
//  AppController.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

final class AppController {
    
    // MARK: Public API
    
    func attachInitialUI(with window: UIWindow?) {
        guard let window = window else { return }
        window.rootViewController = rootViewController()
        window.makeKeyAndVisible()
    }
    
    // MARK: Private API
    
    private func rootViewController() -> UIViewController {
        return NavigationController(rootViewController: SignInViewController())
    }

}
