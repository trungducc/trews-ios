//
//  AppController.swift
//  Trews
//
//  Created by Nguyen Duc on 2/9/19.
//  Copyright © 2019 Nguyen Duc. All rights reserved.
//

import UIKit

final class AppController {
    
    // MARK: Public API
    
    func attachInitialUI(with window: UIWindow?) {
        guard let window = window else { return }
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
    }

}
