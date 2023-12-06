//
//  ChatsViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

class ChatsViewController: UIViewController, ChatsViewInput {

    var output: ChatsViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: ChatsViewInput
    func setupInitialState() {
    }
}
