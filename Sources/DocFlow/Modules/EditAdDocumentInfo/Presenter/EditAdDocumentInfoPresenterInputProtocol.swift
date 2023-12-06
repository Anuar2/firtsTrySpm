//
//  EditAdDocumentInfoPresenterInputProtocol.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit

protocol EditAdDocumentInfoPresenterInputProtocol: class {
    var output: EditAdDocumentInfoPresenterOutputProtocol? { get set }
    
    var attachmentInfo: AttachmentModel? {get set}
    var adDocumentInfo: DocumentViewModel? {get set}
    
    func viewIsReady()
    func dissmiss()
    
    func presentPopUp() -> UIViewController
    func presentPopUpFull() -> UIViewController
    func presentPopUpEmptyInitiator() -> UIViewController
    
    func presentDocumentPickerView()
    func presentInitiatorView()
    func presentStartDateView()
    func presentEndDateView()
    
    func updateDocument()
    func userDidTappedOnPublish()
}

protocol EditAdDocumentInfoPresenterOutputProtocol: class {
    func presentViewModel(_ viewmodel: DocumentViewModel)
    func presentAttachmentModel(_ model: AttachmentModel)
    func presentPublishResult(_ result: Bool)
}
