//
//  EditProfileVC.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 27/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

struct EditProfileModel {
    
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileVC: UIViewController {
    
    // Setup UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.editProfileCell)
        return tableView
    }()
    
    private var models = [[EditProfileModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        
        tableView.dataSource = self
        tableView.tableHeaderView = createTableViewHeaderView()
        
        view.addSubview(tableView)

        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func configureModels() {
        
        // Name, User Name, Website, bio
        let sectionLabels = ["Name", "UserName", "Bio"]
        var section1 = [EditProfileModel]()
        
        for label in sectionLabels {
            
            let model = EditProfileModel(label: label,
                                         placeholder: "Enter \(label)...",
                                         value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        // Email, Phone, Gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileModel]()
        
        for label in section2Labels {
            
            let model = EditProfileModel(label: label,
                                         placeholder: "Enter \(label)...",
                                         value: nil)
            section2.append(model)
        }
        models.append(section2)
    }

    // MARK: - Actions
    @objc private func didTapSave() {
        
        // Save info to Database
    }
    
    @objc private func didTapCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture() {
        
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change Profile Picture",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: TableView
extension EditProfileVC: UITableViewDataSource {
    
    private func createTableViewHeaderView() -> UIView {
        
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height/4).integral)
        
        let size = header.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                        y: (header.height-size)/2,
                                                        width: size,
                                                        height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    @objc private func didTapProfilePhotoButton() {
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.editProfileCell, for: indexPath)
        
        cell.textLabel?.text = model.label
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        guard section == 1 else {
            
            return nil
        }
        
        return "Private Information"
    }
}
