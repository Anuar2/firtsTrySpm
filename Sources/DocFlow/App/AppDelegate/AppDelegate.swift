//
//  File.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let assembler = DependencyContainer.shared.assembler

    private lazy var modulesFactory: ModulesFactory = {
        return ModulesFactory(assembler: assembler)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBar = modulesFactory.makeTabBarView()
        let navVC = UINavigationController(rootViewController: tabBar)
        setupWindow(navVC: navVC)
        
        return true
    }
}

extension AppDelegate {
    func setupWindow(navVC: UINavigationController) {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
