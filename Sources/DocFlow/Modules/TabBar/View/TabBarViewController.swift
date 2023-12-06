//
//  TabBarViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

public class TabBarViewController: UITabBarController, TabBarViewInput {

    var output: TabBarViewOutput?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        setTabBarAppearance()
    }
    
    public init(output: TabBarViewOutput? = nil) {
        self.output = output
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
