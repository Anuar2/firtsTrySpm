//
//  UploadDocumentViewOutput.swift
//
//
//  Created by User on 05.12.2023.
//

protocol UploadDocumentViewOutput {

    /**
        @author Anuar
        Notify presenter that view is ready
    */

    func viewIsReady()
    func presentDocumentPicker()
    func dissmiss()
    
    func uploadDocument(with data: Data?)
}
