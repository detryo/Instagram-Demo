//
//  ProfileInfoHeaderReusableView.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 14/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

// Delegado para hacer funcionar los botones
protocol ProfileInfoHeaderReusableViewDelegate: AnyObject {
    
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderReusableView)
}

final class ProfileInfoHeaderReusableView: UICollectionReusableView {
    
    public weak var delegate: ProfileInfoHeaderReusableViewDelegate?
    
    // de esta manera se diseña la UI en código
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Name"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text  = "Test Bio"
        label.textColor = .label
        label.numberOfLines = 0 // line wrap
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        
        postsButton.frame = CGRect(x: profilePhotoImageView.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postsButton.right,
                                       y: 5,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.right,
                                       y: 5,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                         y: 5 + buttonHeight,
                                         width: countButtonWidth * 3,
                                         height: buttonHeight).integral
        
        nameLabel.frame = CGRect(x: 5,
                                 y: 5 + profilePhotoImageView.bottom,
                                 width: width - 10,
                                 height: 50).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        
        bioLabel.frame = CGRect(x: 5,
                                 y: 5 + nameLabel.bottom,
                                 width: width - 10,
                                 height: bioLabelSize.height).integral
    }
    
    private func addSubViews() {
        
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addButtonActions() {
        
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    // MARK: Button Actions
    
    @objc private func didTapFollowingButton() {
        
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapFollowersButton() {
        
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapPostsButton() {
        
        delegate?.profileHeaderDidTapPostButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        
        
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
