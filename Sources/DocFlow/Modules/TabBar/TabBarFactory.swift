//
//  TabBarFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol TabBarFactory {
    func makeTabBarView() -> UITabBarController
}

extension ModulesFactory: TabBarFactory {
    func makeTabBarView() -> UITabBarController {
        
        let tabBar = TabBarModuleConfigurator().build(factory: self)
        tabBar.modalTransitionStyle = .crossDissolve
        tabBar.modalPresentationStyle = .fullScreen
        
        let homeVC = makeHomeView()
        let myWorkVC = makeMyWorkView()
        let chatsVC = makeChatsView()
        let teamVC = makeTeamView()
        let servicesVC = makeServicesView()
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let myWorkNavVC =  UINavigationController(rootViewController: myWorkVC)
        let chatsNavVC =  UINavigationController(rootViewController: chatsVC)
        let teamNavVC =  UINavigationController(rootViewController: teamVC)
        let servicesNavVC =  UINavigationController(rootViewController: servicesVC)
        
        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: Assets.homeIcon.name), tag: 0)
        myWorkNavVC.tabBarItem = UITabBarItem(title: "My Work", image: UIImage(named: Assets.myWorkIcon.name), tag: 1)
        chatsNavVC.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(named: Assets.chatIcon.name), tag: 2)
        teamNavVC.tabBarItem = UITabBarItem(title: "Team", image: UIImage(named: Assets.peopleTeamIcon.name), tag: 3)
        servicesNavVC.tabBarItem = UITabBarItem(title: "Services", image: UIImage(named: Assets.servicesIcon.name), tag: 4)
        
        tabBar.viewControllers = [homeNavVC, myWorkNavVC, chatsNavVC, teamNavVC, servicesNavVC]
        
        return tabBar
    }
}

