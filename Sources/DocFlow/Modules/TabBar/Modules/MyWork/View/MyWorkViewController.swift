//
//  MyWorkViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class MyWorkViewController: UIViewController, MyWorkViewInput {

    var output: MyWorkViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: MyWorkViewInput
    func setupInitialState() {
    }
}
