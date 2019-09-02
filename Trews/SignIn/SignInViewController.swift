//
//  SignInViewController.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit
import SnapKit

class SignInViewController: ViewController {
    
    private let containerView = UIView()
    private let usernameInputView = InputView()
    private let passwordInputView = InputView()
    private let signInButton = AuthenticationButton()
    private let otherOptionsLabel = UILabel()
    private let facebookButton = UIButton(type: .custom)
    private let googleButton = UIButton(type: .custom)
    private let signUpButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.Strings.signIn

        setupSubviews()
    }
    
    // MARK: Private API
    
    private func setupSubviews() {
        containerView.backgroundColor = .white
        containerView.dropShadow()
        view.addSubview(containerView)
        
        usernameInputView.autocapitalizationType = .none
        usernameInputView.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        usernameInputView.placeholder = Constants.Strings.username
        view.addSubview(usernameInputView)
        
        passwordInputView.autocapitalizationType = .none
        passwordInputView.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        passwordInputView.enableSecurityView = true
        passwordInputView.isSecureTextEntry = true
        passwordInputView.placeholder = Constants.Strings.password
        view.addSubview(passwordInputView)
        
        signInButton.addTarget(self, action: #selector(signInButtonDidTouch), for: .touchUpInside)
        signInButton.isEnabled = false
        signInButton.setTitle(Constants.Strings.signIn, for: .normal)
        view.addSubview(signInButton)
        
        otherOptionsLabel.text = Constants.Strings.otherSignInOptions
        otherOptionsLabel.font = Constants.Font.otherOptionsLabelFont
        otherOptionsLabel.textColor = Constants.Color.otherOptionsLabelTextColor.color
        otherOptionsLabel.textAlignment = .center
        view.addSubview(otherOptionsLabel)
        
        facebookButton.setBackgroundImage(Constants.Image.facebook.image, for: .normal)
        facebookButton.imageView?.contentMode = .scaleAspectFit
        view.addSubview(facebookButton)
        
        googleButton.setBackgroundImage(Constants.Image.google.image, for: .normal)
        googleButton.imageView?.contentMode = .scaleAspectFit
        view.addSubview(googleButton)
        
        signUpButton.setTitle(Constants.Strings.signUp, for: .normal)
        signUpButton.titleLabel?.font = Constants.Font.signUpButtonFont
        signUpButton.setTitleColor(Constants.Color.signUpButtonTextColor.color, for: .normal)
        view.addSubview(signUpButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
        
        usernameInputView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(33)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.height.equalTo(53)
        }
        
        passwordInputView.snp.makeConstraints { make in
            make.top.equalTo(usernameInputView.snp.bottom).offset(25)
            make.leading.equalTo(usernameInputView)
            make.trailing.equalTo(usernameInputView)
            make.height.equalTo(usernameInputView)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordInputView.snp.bottom).offset(25)
            make.leading.equalTo(usernameInputView)
            make.trailing.equalTo(usernameInputView)
            make.height.equalTo(48)
        }
        
        otherOptionsLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(24)
            make.leading.equalTo(usernameInputView)
            make.trailing.equalTo(usernameInputView)
        }
        
        let otherOptionsLayoutGuide = UILayoutGuide()
        view.addLayoutGuide(otherOptionsLayoutGuide)
        
        otherOptionsLayoutGuide.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(otherOptionsLabel.snp.bottom).offset(16)
            make.bottom.equalTo(containerView).offset(-28)
        }
        
        facebookButton.snp.makeConstraints { make in
            make.top.equalTo(otherOptionsLayoutGuide)
            make.leading.equalTo(otherOptionsLayoutGuide)
            make.bottom.equalTo(otherOptionsLayoutGuide)
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(otherOptionsLayoutGuide)
            make.bottom.equalTo(otherOptionsLayoutGuide)
            make.trailing.equalTo(otherOptionsLayoutGuide)
            make.leading.equalTo(facebookButton.snp.trailing).offset(12)
            make.size.equalTo(facebookButton)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func textFieldDidChange(textField: UIInputView) {
        signInButton.isEnabled = usernameInputView.text!.count >= 6 && passwordInputView.text!.count >= 6
    }
    
    @objc private func signInButtonDidTouch() {
        guard let username = usernameInputView.text, let password = passwordInputView.text else {
            return
        }
        
        Client.shared.signIn(username: username, password: password) { _ in
        }
    }

}
