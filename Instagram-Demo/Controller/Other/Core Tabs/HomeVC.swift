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
        
        createMockModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthentication()
    }
    
    private func createMockModel() {
                
        let user = User(userName: "Chris",
                        bio: "",
                        name: (first: "", last: ""),
                        birthDate: Date(),
                        joinDate: Date(),
                        gender: .male,
                        count: UserCount(followers: 1, following: 1, post: 1),
                        profilePhoto: URL(string: "https://www.google.com")!)
        
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)
        
        var comments = [PostComment]()
        
        for x in 0..<2 {
            
            comments.append(PostComment(identifier: "\(x)",
                                        userName: "@Sara",
                                        text: "Nice Post",
                                        createdDate: Date(),
                                        like: []))
        }
        
        for x in 0..<5 {
            
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderedModel.append(viewModel)
        }
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
        
        return feedRenderedModel.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderedModel[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderedModel[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
        } else if subSection == 1 {
            // Post
            return 1
        } else if subSection == 2 {
            // Actions
            return 1
        } else if subSection == 3 {
            // Comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        
        if x == 0 {
            model = feedRenderedModel[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderedModel[position]
        }
        
        let subSection = x % 4
        if subSection == 0 {
            
            // header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostHeaderCell, for: indexPath) as! IGFeedPostHeaderCell
                
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 1 {
            
            // Post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostCell, for: indexPath) as! IGFeedPostCell
                
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
        } else if subSection == 2 {
            
            // Actions
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostActionsCell, for: indexPath) as! IGFeedPostActionsCell
                
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 3 {
            
            // Comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.IGFeedPostGeneralCell, for: indexPath) as! IGFeedPostGeneralCell
                
                return cell
            case .actions, .header, .primaryContent: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            // Header
            return 70
        } else if subSection == 1 {
            // Post
            return tableView.width
        } else if subSection == 2 {
            //Actions (like / comments)
            return 60
        } else if subSection == 3 {
            // Comment row
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let subSection = section % 4
        
        return subSection == 3 ? 70 : 0
    }
}
