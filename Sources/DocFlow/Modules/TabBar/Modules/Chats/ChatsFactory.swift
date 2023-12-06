//
//  ChatsFactory.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit

protocol ChatsFactory {
    func makeChatsView() -> UIViewController
}

extension ModulesFactory: ChatsFactory {
    func makeChatsView() -> UIViewController {
        ChatsModuleConfigurator().build(factory: self)
    }
}
