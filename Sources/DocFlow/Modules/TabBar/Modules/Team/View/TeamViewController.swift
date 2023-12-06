//
//  TeamViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class TeamViewController: UIViewController, TeamViewInput {

    var output: TeamViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: TeamViewInput
    func setupInitialState() {
    }
}
