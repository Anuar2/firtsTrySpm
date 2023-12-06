//
//  ModulesFactory.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Swinject

public final class ModulesFactory {

    // MARK: - Properties

    public let assembler: Assembler

    // MARK: - Init

    public init(assembler: Assembler) {
        self.assembler = assembler
    }
}
