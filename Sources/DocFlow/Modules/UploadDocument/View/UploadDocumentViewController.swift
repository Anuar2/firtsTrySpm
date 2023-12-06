//
//  UploadDocumentViewController.swift
//
//
//  Created by User on 05.12.2023.
//

import UIKit
import PDFKit

protocol UploadDocumentVCDelegate: AnyObject {
    func createDocument(with file: Data?, documentURL: URL?)
}

class UploadDocumentViewController: UIViewController, UploadDocumentViewInput {
    func sendUploadDocument(_ model: AttachmentModel) {
        uploadDocument = model
    }

    var output: UploadDocumentViewOutput?
    weak var delegate: UploadDocumentVCDelegate?

    var selectedFileData: Data? {
        didSet {
            setupViewStatus()
        }
    }
    
    var uploadDocument: AttachmentModel?
    
    var documentURL: URL? {
        didSet {
            setupViewStatus()
        }
    }
    
    //MARK: - View
    private lazy var navigationView: DFFloatingPanelNavBar = {
        let view = DFFloatingPanelNavBar()
        view.navigationTitle = "Upload document"
        view.dissmiss = { [weak self] in
            self?.output?.dissmiss()
        }
        return view
    }()
    
    private lazy var uploadDocView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var addDocumentButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12).cgColor
        button.addTarget(self, action: #selector(addDocumentButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.text = "Permitted files .pdf, .docx no more than 50 MB"
        label.textColor = UIColor(red: 0.545, green: 0.549, blue: 0.62, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var documentTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.988, alpha: 1)
        view.layer.cornerRadius = 12
        view.isHidden = true
        return view
    }()
    
    private lazy var docIconImageView: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(named: Assets.pdfIcon.name)
//        view.isHidden = true
        return view
    }()
    
    private lazy var loaderView = CustomLoaderView()
    
    private lazy var documentTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private lazy var deleteDocumentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Assets.closeIcon.name), for: .normal)
        button.addTarget(self, action: #selector(deleteDocumentButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.426, green: 0.43, blue: 0.52, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.isEnabled = false
        button.backgroundColor = UIColor(red: 0.66, green: 0.66, blue: 0.72, alpha: 1)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewIsReady()
        view.backgroundColor = DFColor.lighBackground
        setup()
    }

    override func updateViewConstraints() {
        self.view.frame.size.height = UIScreen.main.bounds.height/2.5
        self.view.frame.origin.y = UIScreen.main.bounds.height -  UIScreen.main.bounds.height/2.5
        self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        super.updateViewConstraints()
    }

    // MARK: UploadDocumentViewInput
    func setupInitialState() {
    }
    
    //MARK: - Methdos
    @objc private func addDocumentButtonDidTap() {
        output?.presentDocumentPicker()
    }
    
    @objc private func nextButtonDidTap() {
        if selectedFileData != nil {
            output?.dissmiss()
            delegate?.createDocument(with: selectedFileData, documentURL: documentURL)
        }
    }
    
    @objc private func deleteDocumentButtonDidTap() {
        selectedFileData = nil
        documentTitleLabel.text = nil
        setupViewStatus()
    }
    
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [navigationView, uploadDocView, nextButton].forEach {
            view.addSubview($0)
        }
        
        [addDocumentButton, noteLabel, documentTitleView].forEach {
            uploadDocView.addSubview($0)
        }
        
        [docIconImageView, documentTitleLabel, subtitleLabel, deleteDocumentButton, loaderView].forEach {
            documentTitleView.addSubview($0)
        }
    }
    
    private func setupViewStatus() {
        [documentTitleView, documentTitleLabel, subtitleLabel].forEach {
            $0.isHidden = selectedFileData == nil ? true : false
        }
        
        [addDocumentButton, noteLabel].forEach {
            $0.isHidden = selectedFileData == nil ? false : true
        }
        
        loaderView.startAnimating()
        docIconImageView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loaderView.stopAnimating()
            self.docIconImageView.isHidden = false
            self.docIconImageView.image = UIImage(named: self.documentURL?.lastPathComponent.contains("pdf") == true ? Assets.pdfIcon.name : Assets.doc.name)
        }
        
        nextButton.isEnabled = selectedFileData == nil ? false : true
        nextButton.backgroundColor = selectedFileData == nil ? UIColor(red: 0.66, green: 0.66, blue: 0.72, alpha: 1) : UIColor(red: 0.88, green: 0.38, blue: 0.23, alpha: 1)
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/13)
        }
        
        uploadDocView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(109)
        }
        
        addDocumentButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(addDocumentButton.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(16)
        }
        
        documentTitleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
        
        docIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(12)
            make.height.width.equalTo(24)
        }
        
        loaderView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(12)
            make.height.width.equalTo(24)
        }
        
        documentTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalTo(docIconImageView.snp.trailing).offset(12)
            make.trailing.equalTo(deleteDocumentButton.snp.leading).offset(-12)
            make.height.equalTo(18)
        }
        
        deleteDocumentButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(documentTitleLabel.snp.bottom).offset(2)
            make.leading.equalTo(docIconImageView.snp.trailing).offset(12)
            make.height.equalTo(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(uploadDocView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
    }
}

//MARK: - UIDocumentPickerDelegate
extension UploadDocumentViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedURL = urls.first else { return }
        print(String(describing: selectedURL))
        let fileExtension = selectedURL.pathExtension

        do {
            selectedFileData = try Data(contentsOf: selectedURL)
            
            if !selectedURL.lastPathComponent.isEmpty {
                documentTitleLabel.text = selectedURL.lastPathComponent
                self.documentURL = selectedURL
            }
            
            output?.uploadDocument(with: "\(selectedURL)")
        } catch {
            print("Error reading file: \(error)")
        }
    }
}

extension UploadDocumentViewController {
    func getTitleFromPDF(url: URL) -> String? {
        if let pdfDocument = PDFDocument(url: url), let page = pdfDocument.page(at: 0) {
            let attributedString = page.attributedString
            return attributedString?.string
        }
        return nil
    }
}
