//
//  EditDocumentInfoPresenterInputProtocol.swift
//  
//
//  Created by Anuar Orazbekov on 05.12.2023.
//


import UIKit

protocol EditDocumentInfoPresenterInputProtocol {
    var output: EditDocumentInfoPresenterOutputProtocol? { get set }
    var viewmodel: DocumentViewModel? { get set }
    
    func viewIsReady()
    
    func presentInitiatorView()
    func presentPopUp() -> UIViewController
    func presentPopUpEmptyInitiator() -> UIViewController
    func presentPopUpFull() -> UIViewController
    func userDidTappedOnPublish()
    func dissmiss()
}

protocol EditDocumentInfoPresenterOutputProtocol: AnyObject {
    func presentPublishResult(_ result: Bool)
    func presentViewModel(_ viewmodel: DocumentViewModel)
}
