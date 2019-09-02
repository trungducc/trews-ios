//
//  SignUpViewControllerDelegate.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate: class {
    
    func didSignUpSuccess(viewController: SignUpViewController, username: String, password: String)
    
}
