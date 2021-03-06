//
//  ProfileVC.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 27/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

/// Profile View Controller
final class ProfileVC: UIViewController {
    
    private var collectionView: UICollectionView?
    let layout = UICollectionViewFlowLayout()
    
    private var userPost = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.backgroundColor = .red
        
        // Cell
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: Identifier.photoCell)
        
        // Headers
        collectionView?.register(ProfileInfoHeaderReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: Identifier.profileInfoHeaderReusableView)
        
        collectionView?.register(ProfileTabReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: Identifier.profileTabReusableView)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() {
        
        let viewController = SettingsVC()
        viewController.title = "Settings"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 0
        }
       // return userPost.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let model = userPost[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.photoCell, for: indexPath) as! PhotoCell
        
        //cell.configure(with: model)
        cell.configure(debug: "test")
        
        return cell
    }
    
    // Esta funcion vale cuando el usuario presiona una celda
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // get the model and open PostVC.swift
        
        //let model = userPost[indexPath.row]
        
        let postVC = PostVC(model: nil)
        postVC.title = "Post"
        postVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            // Footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            // tabs header
            let tabControllHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: Identifier.profileTabReusableView,
                                                                         for: indexPath) as! ProfileTabReusableView
            
            tabControllHeader.delegate = self
            
            return tabControllHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: Identifier.profileInfoHeaderReusableView,
                                                                     for: indexPath) as! ProfileInfoHeaderReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    // Esta funcion vale para poner el tamaño de la Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        // Esto mide el ancho de la primera header
        if section == 0 {
            return CGSize(width: collectionView.width,
                          height: collectionView.height/3)
        }
        // Size of section tabs, Este es para la segunda header
        return CGSize(width: collectionView.width,
                      height: 50)
    }
}

extension ProfileVC: ProfileInfoHeaderReusableViewDelegate {
    
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderReusableView) {
        
        // scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderReusableView) {
        
        var mockData = [UserRelationship]()
        
        for x in 0..<10 {
            
            mockData.append(UserRelationship(userName: "@Chris",
                                             nname: "Chris",
                                             type: x % 2 == 0 ? .following : .not_following))
        }
        
        let viewController = ListVC(data: mockData)
        viewController.title = "Followers"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderReusableView) {
        
        var mockData = [UserRelationship]()
        
        for x in 0..<10 {
            
            mockData.append(UserRelationship(userName: "@Chris",
                                             nname: "Chris",
                                             type: x % 2 == 0 ? .following : .not_following))
        }
        
        let viewController = ListVC(data: mockData)
        viewController.title = "Following"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderReusableView) {
        
        let viewController = EditProfileVC()
        viewController.title = "Edit Profile"
        present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
}

extension ProfileVC: ProfileTabReusableViewDelegate {
    
    func didTapGridButtonTab() {
        
        // Reload collection view with data
        
    }
    
    func didTapTaggedbuttonTab() {
        
        // Reload collection view with data
        
    }
}
