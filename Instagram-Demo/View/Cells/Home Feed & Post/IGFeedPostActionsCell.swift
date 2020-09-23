//
//  IGFeedPostActionsCell.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 03/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class IGFeedPostActionsCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        
        // Configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
