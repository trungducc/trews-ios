//
//  CreateTrewsViewController.swift
//  Trews
//
//  Created by Nguyen Duc on 3/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit

class CreateTrewsViewController: ViewController, UITextViewDelegate {
    
    weak var delegate: CreateTrewsViewControllerDelegate?
    
    private let trewsTextView = UITextView()
    private let postButton = GradientButton()
    
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
        
        view.layer.cornerRadius = 12
        preferredContentSize = CGSize(width: view.bounds.width, height: 200)
        
        setupSubviews()
    }
    
    // MARK: UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        postButton.isEnabled = textView.text.count > 0
    }
    
    // MARK: Private API
    
    private func setupSubviews() {
        trewsTextView.backgroundColor = .clear
        trewsTextView.font = UIFont.regularProTextFont(ofSize: 14)
        trewsTextView.textColor = Constants.Color.black.color
        trewsTextView.delegate = self
        view.addSubview(trewsTextView)
        
        postButton.addTarget(self, action: #selector(postButtonDidTouch), for: .touchUpInside)
        postButton.isEnabled = false
        postButton.setTitle(Constants.Strings.post, for: .normal)
        view.addSubview(postButton)
        
        let padding = 16
        
        trewsTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.bottom.equalTo(postButton.snp.top).offset(-padding)
        }
        
        postButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.bottom.equalToSuperview().offset(-padding)
            make.height.equalTo(48)
        }
    }
    
    @objc private func postButtonDidTouch() {
        view.endEditing(true)
        
        client.createTrews(title: trewsTextView.text) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.showMessage(error)
            } else {
                self.delegate?.didCreateTrewsSuccess(viewController: self)
            }
        }
    }
    
}
