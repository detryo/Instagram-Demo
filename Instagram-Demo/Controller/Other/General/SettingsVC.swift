//
//  SettingsVC.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 27/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import SafariServices

struct SettingsCellModel {
    
    let title: String
    let handler: (() -> Void)
}

enum SettingsURLType {
    
    case terms, privacy, help
}

/// View Controller to show user settings
final class SettingsVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.settingsCell)
        return tableView
    }()
    
    private var data = [[SettingsCellModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        data.append([
            SettingsCellModel(title: "Edit Profile") { [weak self] in
                
                self?.didTapEditProfile()
            
            },
            
            SettingsCellModel(title: "Invite Friends") { [weak self] in
                
                self?.didTapInviteFriends()
            },
            
            SettingsCellModel(title: "Save Original Posts") { [weak self] in
                
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingsCellModel(title: "Terms Of Service") { [weak self] in
            
                self?.openURL(type: .terms)
            },
            
            SettingsCellModel(title: "Privacy Policy") { [weak self] in
            
                self?.openURL(type: .privacy)
            },
            
            SettingsCellModel(title: "Help / Feedback") { [weak self] in
            
                self?.openURL(type: .help)
            }
        ])

        data.append([ SettingsCellModel(title: "Log Out") { [weak self] in
            
            self?.didTapLogOut()
            }
        ])
    }
    
    private func openURL(type: SettingsURLType) {
        
        let urlString: String
        
        switch type {
        case .terms: urlString = "https://help.instagram.com/478745558852511/?helpref=hc_fnav"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    private func didTapSaveOriginalPosts() {
        
        
    }
    
    private func didTapInviteFriends() {
        
        // Show share sheet to invite friends
    }
    
    private func didTapEditProfile() {
        
        let viewController = EditProfileVC()
        viewController.title = "Edit Profile"
        
        let navViewController = UINavigationController(rootViewController: viewController)
        present(navViewController, animated: true, completion: nil)
    }
    
    private func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancell", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            
            AuthManager.shared.logOut(complition: { success in
                
                DispatchQueue.main.async {
                    
                    if success {
                        // present Log In
                        let loginVC = LoginVC()
                        loginVC.modalPresentationStyle = .fullScreen
                        
                        self.present(loginVC, animated: true) {
                            
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                        
                    } else {
                        // error
                        self.simpleAlert(title: "Error", message: "Could")
                    }
                }
            })
        }))
        // esta accion es para el Ipad, si no la ponemos, no sabe como presentarlo y se rompe la aplicacion
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.settingsCell, for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}
