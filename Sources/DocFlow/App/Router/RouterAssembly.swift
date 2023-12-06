//
//  File.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import Swinject

struct RouterAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DFRouter.self) { r in
            DFRouter(navigationController: UINavigationController())
        }.inObjectScope(.container)
    }
}
