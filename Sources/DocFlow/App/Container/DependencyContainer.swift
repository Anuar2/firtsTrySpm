//
//  DependencyContainer.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

struct DependencyContainer {
    static let shared = DependencyContainer()
    
    let assembler = AssemblerFactory().makeAssembler()
    
    func resolve<T>(_ type: T.Type) -> T? {
        assembler.resolver.resolve(T.self)
    }
}
