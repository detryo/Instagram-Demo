//
//  UserFollowCell.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 17/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

protocol UserFollowCellDelegate: AnyObject {
    
    func didTapFollowUnFollowButton(model: UserRelationship)
}

enum FollowState {
    
    case following, not_following
}

struct UserRelationship {
    
    let userName: String
    let nname: String
    let type: FollowState
}

class UserFollowCell: UITableViewCell {
    
    weak var delegate: UserFollowCellDelegate?
    private var model: UserRelationship?
    
    // Design UI
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Chris"
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@Chris"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link //
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(followButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
        
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sizeHeight = contentView.height - 6
        let sizeWidth = contentView.width - 8
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width:  sizeHeight,
                                        height: sizeHeight)
        
        profileImageView.layer.cornerRadius = profileImageView.height / 2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3
        
        followButton.frame = CGRect(x: contentView.width - 5 - buttonWidth,
                                    y: (contentView.height - 40) / 2,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height / 2
        
        nameLabel.frame = CGRect(x: profileImageView.right + 5,
                                y: 0,
                                width: sizeWidth - profileImageView.width - buttonWidth,
                                height: labelHeight)
        
        userNameLabel.frame = CGRect(x: profileImageView.right + 5,
                                     y: nameLabel.bottom,
                                 width: sizeWidth - profileImageView.width - buttonWidth,
                                 height: labelHeight)
        
    }
    //
    public func configure(with model: UserRelationship) {
        
        self.model = model
        
        nameLabel.text = model.nname
        userNameLabel.text = model.userName
        
        switch model.type {
            
        case .following:
            // Show unFollow button
            followButton.setTitle("UnFollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            
        case .not_following:
            // Show Follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
    @objc private func didTapFollowButton() {
        
        guard let model = model else { return }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
}
