//
//  NewsViewController.swift
//  Trews
//
//  Created by trungducc on 2/9/19.
//  Copyright © 2019 trungducc. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialDialogs

enum Section: Int, CaseIterable {
    case create = 0, list
}

class NewsViewController: ViewController, UITableViewDelegate, UITableViewDataSource, CreateTrewsViewControllerDelegate, TrewsCellDelegate {
    
    weak var delegate: NewsViewControllerDelegate?
    
    private let tableView = UITableView()
    private var dialogTransitionController: MDCDialogTransitionController!
    
    private let client: Client
    
    private var trews = [Trews]()
    
    init(client: Client) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.Strings.news
        
        setupSignOutButton()
        setupSubviews()
        reloadTrews()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.create.rawValue:
            return 1
        case Section.list.rawValue:
            return trews.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.create.rawValue:
            return createTrewsCell()
        case Section.list.rawValue:
            return trewsCellForRow(at: indexPath.row)
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.create.rawValue:
            return 72
        case Section.list.rawValue:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case Section.create.rawValue:
            showCreateTrewsDialog()
        case Section.list.rawValue:
            break
        default:
            break
        }
    }
    
    // MARK: TrewsCellDelegate
    
    func likeButtonDidTouch(cell: TrewsCell) {
        guard let indexPath = tableView.indexPath(for: cell), indexPath.row < trews.count else {
            return
        }
        
        reactTrews(at: indexPath, type: .like)
    }
    
    func dislikeButtonDidTouch(cell: TrewsCell) {
        guard let indexPath = tableView.indexPath(for: cell), indexPath.row < trews.count else {
            return
        }
        
        reactTrews(at: indexPath, type: .dislike)
    }
    
    // MARK: CreateTrewsViewControllerDelegate
    
    func didCreateTrewsSuccess(viewController: CreateTrewsViewController) {
        viewController.dismiss(animated: true, completion: nil)
        reloadTrews()
    }
    
    // MARK: Private API
    
    private func setupSubviews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(TrewsCell.self, forCellReuseIdentifier: NSStringFromClass(TrewsCell.self))
        tableView.register(CreateTrewsCell.self, forCellReuseIdentifier: NSStringFromClass(CreateTrewsCell.self))
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        view.addSubview(tableView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(triggerPullToRefreshHandler), for: .valueChanged)
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        tableView.refreshControl = refreshControl
    }
    
    private func setupSignOutButton() {
        let signOutItem = UIBarButtonItem(image: Constants.Image.signOut.image?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showSignOutAlert))
        navigationItem.rightBarButtonItem = signOutItem
    }
    
    private func reloadTrews() {
        guard let refreshControl = tableView.refreshControl else {
            return
        }
        
        if refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
        }
        
        client.listTrews { [weak self] result in
            guard let self = self, let trews = result.value else {
                refreshControl.endRefreshing()
                return
            }
            
            self.tableView.performBatchUpdates({
                self.trews = trews
                self.tableView.reloadSections([Section.list.rawValue], with: .fade)
            }, completion: { _ in
                refreshControl.endRefreshing()
            })
        }
    }
    
    private func createTrewsCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CreateTrewsCell.self)) as? CreateTrewsCell else {
            return UITableViewCell()
        }
        cell.display(username: client.username)
        return cell
    }
    
    private func trewsCellForRow(at index: Int) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TrewsCell.self)) as? TrewsCell, index < trews.count else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.display(trews: trews[index])
        return cell
    }
    
    @objc private func triggerPullToRefreshHandler() {
        reloadTrews()
    }
    
    @objc private func showSignOutAlert() {
        showConfirmAlert(title: Constants.Strings.signOut, message: Constants.Strings.signOutMessage) { [weak self] isConfirmed in
            guard let self = self, isConfirmed else { return }
            self.signOut()
        }
    }
    
    private func signOut() {
        client.signOut(completion: { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.showMessage(error)
            } else {
                self.delegate?.didSignOutSuccess(viewController: self)
            }
        })
    }
        
    private func showCreateTrewsDialog() {
        dialogTransitionController = MDCDialogTransitionController()
        
        let createTrewsViewController = CreateTrewsViewController(client: client)
        createTrewsViewController.delegate = self
        createTrewsViewController.modalPresentationStyle = .custom
        createTrewsViewController.transitioningDelegate = dialogTransitionController
        
        present(createTrewsViewController, animated: true, completion: nil)
    }
    
    private func reactTrews(at indexPath: IndexPath, type: ReactionType) {
        let reactedTrews = trews[indexPath.row]
        let finalType: ReactionType = reactedTrews.reactionType != type ? type : .none
        
        client.reactTrews(id: reactedTrews.id, type: finalType) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.showMessage(error)
            case .success(let reactedTrews):
                self.update(reactedTrews: reactedTrews, at: indexPath)
            }
        }
    }
    
    private func update(reactedTrews: Trews, at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TrewsCell, indexPath.row < trews.count else {
            return
        }
        trews[indexPath.row] = reactedTrews
        cell.display(trews: reactedTrews)
    }
    
}
