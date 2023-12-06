//
//  UploadDocumentViewInput.swift
//
//
//  Created by User on 05.12.2023.
//

protocol UploadDocumentViewInput: AnyObject {

    /**
        @author Anuar
        Setup initial state of the view
    */

    func setupInitialState()
    func sendUploadDocument(_ model: UploadDocument)
}
