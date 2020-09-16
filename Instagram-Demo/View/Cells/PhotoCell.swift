//
//  PhotoCell.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 14/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCell: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        return photoImageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-Tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        
        let url = model.thumbnailImage
        
        photoImageView.sd_setImage(with: url, completed: nil)
    }
    
    public func configure(debug imageName: String) {
        
        photoImageView.image = UIImage(named: "test")
    }
}
