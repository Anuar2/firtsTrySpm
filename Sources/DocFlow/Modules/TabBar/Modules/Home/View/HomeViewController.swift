//
//  HomeViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {

    var output: HomeViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
    }


    // MARK: HomeViewInput
    func setupInitialState() {
    }
}
