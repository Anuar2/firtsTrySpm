//
//  PDFFileViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import PDFKit

class PDFFileViewController: UIViewController, PDFFileViewInput {
    
    var pdfData: Data?
    var output: PDFFileViewOutput?

    private lazy var pdfView: PDFView = {
        let view = PDFView(frame: view.bounds)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        setup()
    }


    // MARK: PDFFileViewInput
    func setupInitialState() {
    }
    
    private func setup() {
        loadPDFData()
        setupViews()
        makeConstraints()
    }
    
    private func loadPDFData() {
        if let pdfData = pdfData {
            if let pdfDocument = PDFDocument(data: pdfData) {
                pdfView.document = pdfDocument
                pdfView.autoScales = true
                pdfView.displayMode = .singlePageContinuous
            } 
    }
    
    private func setupViews() {
        [pdfView].forEach {
            view.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        pdfView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}
