//
//  AppCoordinator.swift
//  ConvertyRx
//
//  Created by Daniel Dluznevskij on 2020-08-12.
//  Copyright © 2020 Daniel Dluznevskij. All rights reserved.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow?
    
    init (window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = ViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
