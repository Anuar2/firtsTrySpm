//
//  RevokeDocumentAlertViewOutput.swift
//
//
//  Created by User on 05.12.2023.
//

import Foundation

protocol RevokeDocumentAlertViewOutput {

    /**
        @author Anuar
        Notify presenter that view is ready
    */

    func viewIsReady()
    
    func dissmiss()
    
    func revokeRequest()
}
