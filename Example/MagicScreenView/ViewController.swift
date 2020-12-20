//
//  AppDelegate.swift
//  MagicScreenView
//
//  Created by Serhii Matvieiev on 12/12/2020.
//  Copyright (c) 2020 OBRIO. All rights reserved.
//

import UIKit
import MagicScreenView

class ViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let magicScreenView: MagicScreenView = {
        let screenView = MagicScreenView()
        screenView.scrollView.contentInsetAdjustmentBehavior = .never
        screenView.scrollView.bounces = false
        screenView.translatesAutoresizingMaskIntoConstraints = false
        return screenView
    }()
    
    private let profile = Profile()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        magicScreenView.contentInset.bottom = view.safeAreaInsets.bottom + 16
    }

    // MARK: - Private
    
    private func setupView() {
        magicScreenView.isDebugEnabled = true
        magicScreenView.configure(withImage: UIImage(named: "profileRosalie"))
        let actions = profile.actions.compactMap { action in
            MagicAction(frame: action.frame, touchAreaInset: 8) { [unowned self] in
                self.handleAction(action)
            }
        }
        magicScreenView.addActions(actions)
    }
    
    private func setupLayout() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(magicScreenView)
        NSLayoutConstraint.activate([
            magicScreenView.leftAnchor.constraint(equalTo: view.leftAnchor),
            magicScreenView.topAnchor.constraint(equalTo: view.topAnchor),
            magicScreenView.rightAnchor.constraint(equalTo: view.rightAnchor),
            magicScreenView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func handleAction(_ action: Profile.Action) {
        let alert = UIAlertController(title: "\(action.name) action", message: "\(action.name) page opened", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

