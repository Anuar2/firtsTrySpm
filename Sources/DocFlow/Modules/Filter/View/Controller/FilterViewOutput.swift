//
//  File.swift
//  
//
//  Created by User on 05.12.2023.
//

protocol FilterViewOutput {

    /**
        @author Anuar
        Notify presenter that view is ready
    */

    func viewIsReady()
    
    func presentDocTypeView()
    func presentFilterInitiatorView()
    func presentCreationDateView()
    func presentExpireDateView()
    func presentLastModifitedView()
}
