//
//  ViewController.swift
//  Trews
//
//  Created by Nguyen Duc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Color.viewControllerBackground.color
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTouchOutside))
        view.addGestureRecognizer(gesture)
    }
    
    // MARK: Public API
    
    func showMessage(_ message: String) {
        let snackbarMessage = MDCSnackbarMessage()
        snackbarMessage.text = message
        MDCSnackbarManager.show(snackbarMessage)
    }
    
    // MARK: Private API
    
    @objc private func didTouchOutside() {
        view.endEditing(true)
    }
    
}
