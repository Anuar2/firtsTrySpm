//
//  TabBarViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class TabBarViewController: UITabBarController, TabBarViewInput {

    var output: TabBarViewOutput?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        setTabBarAppearance()
    }


    // MARK: TabBarViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methods
    private func setTabBarAppearance() {
        tabBar.backgroundColor = .white
        view.backgroundColor = .white
    }
}
