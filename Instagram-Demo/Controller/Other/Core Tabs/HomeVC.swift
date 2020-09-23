//
//  ViewController.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 27/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeVC: UIViewController {
    
    private var feedRenderedModel = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // Register Cells
        tableView.register(IGFeedPostCell.self, forCellReuseIdentifier: Identifier.IGFeedPostCell)
        tableView.register(IGFeedPostHeaderCell.self, forCellReuseIdentifier: Identifier.IGFeedPostHeaderCell)
        tableView.register(IGFeedPostActionsCell.self, forCellReuseIdentifier: Identifier.IGFeedPostActionsCell)
        tableView.register(IGFeedPostGeneralCell.self, forCellReuseIdentifier: Identifier.IGFeedPostGeneralCell)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthentication()
    }
    
    private func handleNotAuthentication() {
        // Check Auth Status
        if Auth.auth().currentUser == nil {
            // Show Log In
            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostCell, for: indexPath) as! IGFeedPostCell
        
        return cell
    }
}
