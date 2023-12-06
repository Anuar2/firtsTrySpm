//
//  AssemblerFactory.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Swinject
import UIKit

final class AssemblerFactory {
    func makeAssembler() -> Assembler {
        Assembler(
            [
                RouterAssembly()
            ]
        )
    }
}
