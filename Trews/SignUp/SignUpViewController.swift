//
//  SignUpViewController.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

class SignUpViewController: ViewController {
    
    weak var delegate: SignUpViewControllerDelegate?
    
    private let containerView = UIView()
    private let usernameInputView = InputView()
    private let passwordInputView = InputView()
    private let reenterPasswordInputView = InputView()
    private let signUpButton = AuthenticationButton()
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.Strings.signUp

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
        
        reenterPasswordInputView.autocapitalizationType = .none
        reenterPasswordInputView.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        reenterPasswordInputView.enableSecurityView = true
        reenterPasswordInputView.isSecureTextEntry = true
        reenterPasswordInputView.placeholder = Constants.Strings.reenterPassword
        view.addSubview(reenterPasswordInputView)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonDidTouch), for: .touchUpInside)
        signUpButton.isEnabled = false
        signUpButton.setTitle(Constants.Strings.signUp, for: .normal)
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
        
        reenterPasswordInputView.snp.makeConstraints { make in
            make.top.equalTo(passwordInputView.snp.bottom).offset(25)
            make.leading.equalTo(usernameInputView)
            make.trailing.equalTo(usernameInputView)
            make.height.equalTo(usernameInputView)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(reenterPasswordInputView.snp.bottom).offset(25)
            make.leading.equalTo(usernameInputView)
            make.trailing.equalTo(usernameInputView)
            make.bottom.equalTo(containerView).offset(-28)
            make.height.equalTo(48)
        }
    }
    
    @objc private func textFieldDidChange(textField: UIInputView) {
        signUpButton.isEnabled = usernameInputView.text!.count >= 6 && passwordInputView.text!.count >= 6 && passwordInputView.text == reenterPasswordInputView.text
    }
    
    @objc private func signUpButtonDidTouch() {
        view.endEditing(true)

        guard let username = usernameInputView.text, let password = passwordInputView.text else {
            return
        }

        client.signUp(username: username, password: password) { error in
            if let error = error {
                self.showMessage(error)
            } else {
                self.delegate?.didSignUpSuccess(viewController: self, username: username, password: password)
            }
        }
    }
    
}
