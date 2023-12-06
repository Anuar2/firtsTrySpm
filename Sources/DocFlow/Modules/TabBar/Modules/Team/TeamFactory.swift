//
//  TeamFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol TeamFactory {
    func makeTeamView() -> UIViewController
}

extension ModulesFactory: TeamFactory {
    func makeTeamView() -> UIViewController {
        TeamModuleConfigurator().build(factory: self)
    }
}
