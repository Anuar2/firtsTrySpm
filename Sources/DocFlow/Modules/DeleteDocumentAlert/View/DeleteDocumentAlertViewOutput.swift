//
//  DeleteDocumentAlertViewOutput.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol DeleteDocumentAlertViewOutput {

    /**
        @author Anuar
        Notify presenter that view is ready
    */

    func viewIsReady()
    
    func dissmiss()
    
    func deleteRequest()
}
