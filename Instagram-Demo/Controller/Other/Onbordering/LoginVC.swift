//
//  LoginVC.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 27/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    private let userNameEmailField: UITextField = {
       return UITextField()
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
       return UIButton()
    }()
    
    private let termsButton: UIButton = {
       return UIButton()
    }()
    
    private let privacyButton: UIButton = {
       return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
       return UIButton()
    }()
    
    private let headerView: UIView = {
       return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
    }
    
    private func addSubViews() {
        
        view.addSubview(userNameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {
        
        
    }
    
    @objc private func didTapTermsButton() {
        
        
    }
    
    @objc private func didTapPrivacyButton() {
        
        
    }
    
    @objc private func didTapCreateAccountButton() {
        
        
    }
}
