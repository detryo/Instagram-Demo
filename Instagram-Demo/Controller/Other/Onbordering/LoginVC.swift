//
//  LoginVC.swift
//  Instagram-Demo
//
//  Created by Cristian Sedano Arenas on 27/08/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import UIKit
import SafariServices

class LoginVC: UIViewController {
    
    private let userNameEmailField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "UserName or Email"
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField =  UITextField()
        textField.placeholder = "Password"
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Terms Of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
       let button =  UIButton()
       button.setTitle("Privacy Policy", for: .normal)
       button.setTitleColor(.secondaryLabel, for: .normal)
       return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create An Account", for: .normal)
        
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundColor = UIImageView(image: UIImage(named: AppImage.instagramHeader))
        header.addSubview(backgroundColor)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)

        userNameEmailField.delegate = self
        passwordField.delegate = self
        
        addSubViews()
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames
        headerView.frame = CGRect(
                                  x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0)
        
        userNameEmailField.frame = CGRect(
                                  x: 25,
                                  y: headerView.bottom + 40,
                                  width: view.width - 50,
                                  height: 52.0)
        
        passwordField.frame = CGRect(
                                  x: 25,
                                  y: userNameEmailField.bottom + 10,
                                  width: view.width - 50,
                                  height: 52.0)
        
        loginButton.frame = CGRect(
                                  x: 25,
                                  y: passwordField.bottom + 10,
                                  width: view.width - 50,
                                  height: 52.0)
        
        createAccountButton.frame = CGRect(
                                  x: 25,
                                  y: loginButton.bottom + 10,
                                  width: view.width - 50,
                                  height: 52.0)
        
        termsButton.frame = CGRect(
                                  x: 10,
                                  y: view.height - view.safeAreaInsets.bottom - 100,
                                  width: view.width - 20,
                                  height: 50)
        
        privacyButton.frame = CGRect(
                                  x: 10,
                                  y: view.height - view.safeAreaInsets.bottom - 50,
                                  width: view.width - 20,
                                  height: 50)
        
        configurationHeaderView()
    }
    
    private func configurationHeaderView() {
        
        guard headerView.subviews.count == 1 else { return }
        guard let backgroundView = headerView.subviews.first else { return }
        backgroundView.frame = headerView.bounds
        
        // Add Instagram Logo
        let imageView = UIImageView(image: UIImage(named: AppImage.logo))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
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
        
        passwordField.resignFirstResponder()
        userNameEmailField.resignFirstResponder()
        
        guard let userNameEmail = userNameEmailField.text, !userNameEmail.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8 else { return }
        
        // login functionallity
        
    }
    
    @objc private func didTapTermsButton() {
        
        guard let url = URL(string: "https://help.instagram.com/478745558852511/?helpref=hc_fnav") else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyButton() {
        
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    @objc private func didTapCreateAccountButton() {
        
        let viewController = RegistrationVC()
        present(viewController, animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userNameEmailField {
            
            passwordField.becomeFirstResponder()
            
        } else if textField == passwordField {
            
            didTapLoginButton()
        }
        
        return true
    }
}
