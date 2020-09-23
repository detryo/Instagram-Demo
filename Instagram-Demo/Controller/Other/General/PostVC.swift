//
//  PostVC.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 27/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

/// State of a rendered cell
enum PostRenderType {
    
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: String) // Like, comment, share
    case comments(comments: [PostComment])
}

// Model of rendered post
struct PostRenderViewModel {
    
    let renderType: PostRenderType
}

class PostVC: UIViewController {
    
    private let model: UserPost?
    private var renderedModel = [PostRenderViewModel]()
    
    // Diseñando la interfaz
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        // Register Cells
        tableView.register(IGFeedPostCell.self, forCellReuseIdentifier: Identifier.IGFeedPostCell)
        tableView.register(IGFeedPostHeaderCell.self, forCellReuseIdentifier: Identifier.IGFeedPostHeaderCell)
        tableView.register(IGFeedPostActionsCell.self, forCellReuseIdentifier: Identifier.IGFeedPostActionsCell)
        tableView.register(IGFeedPostGeneralCell.self, forCellReuseIdentifier: Identifier.IGFeedPostGeneralCell)
        return tableView
    }()
    
    init(model: UserPost?) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        guard let userPostModel = self.model else { return }
        
        // Header
        renderedModel.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        
        // Post
        renderedModel.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        
        // Actions
        renderedModel.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        // Commerts
        var comments = [PostComment]()
        
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        userName: "@Chris",
                                        text: "Nice One Dude!",
                                        createdDate: Date(),
                                        like: []))
        }
        renderedModel.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
}

extension PostVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderedModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch renderedModel[section].renderType {
            
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = renderedModel[indexPath.section]
        
        switch model.renderType {
            
            case .actions(let actions):
            
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostActionsCell, for: indexPath) as! IGFeedPostActionsCell
                
                return cell
            
            case .comments(_):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostGeneralCell, for: indexPath) as! IGFeedPostGeneralCell
            
            return cell
            
            case .primaryContent(let post):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostCell, for: indexPath) as! IGFeedPostCell
            
            return cell
            
            case .header(let user):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostHeaderCell, for: indexPath) as! IGFeedPostHeaderCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = renderedModel[indexPath.section]
        
        switch model.renderType {
            
            case .actions(_): return 60
            case .comments(_): return 50
            case .primaryContent(_): return tableView.width
            case .header(_): return 70
        }
    }
}
