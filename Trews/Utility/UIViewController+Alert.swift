//
//  UIViewController+Alert.swift
//  Trews
//
//  Created by trungducc on 3/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showConfirmAlert(title: String?, message: String?, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Constants.Strings.cancel, style: .cancel) { _ in
            completion(false)
        }
        let acceptAction = UIAlertAction(title: Constants.Strings.yes, style: .default) { _ in
            completion(true)
        }
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        present(alert, animated: true, completion: nil)
    }
    
}
