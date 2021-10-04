//
//  AuthorizationViewController.swift
//  VKNewsFeed
//
//  Created by Apple on 29.09.2021.
//

import UIKit

class AuthorizationViewController: UIViewController {

    private var authorizationService = SceneDelegate.shared().authorizationService

    private lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        logInButton.setTitle("Войти в VK", for: .normal)
        logInButton.backgroundColor = .systemBlue
        logInButton.setTitleColor(.darkGray, for: .highlighted)
        logInButton.clipsToBounds = true
        logInButton.layer.cornerRadius = 10
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return logInButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logInButton)
        setupLayout()
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logInButton.widthAnchor.constraint(equalToConstant: 200),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc func loginButtonAction() {
        print("login button ispressed")
        authorizationService!.wakeUpSession()
    }
}

