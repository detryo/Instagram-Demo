//
//  ProfileTabReusableView.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 14/09/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class ProfileTabReusableView: UICollectionReusableView {
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
