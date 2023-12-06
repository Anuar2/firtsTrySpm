//
//  PDFFileRouter.swift
//
//
//  Created by User on 05.12.2023.
//

class PDFFileRouter: PDFFileRouterInput {
    var factory: ModulesFactory
    
    var router = DependencyContainer.shared.resolve(DFRouter.self)
    
    weak var viewController: PDFFileViewController?
    
    init(factory: ModulesFactory) {
        self.factory = factory
    }
    
    func showPDFFileView() {
        guard let router = router, let viewController = viewController else {return}
        
        router.push(viewController)
    }
}
