//
//  PreviewView.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import UIKit
import PDFKit
import WebKit

final class PreviewView: UICollectionViewCell {
    
    //MARK: - Properties
    var signatoriesList: [FilterInitiatorModel] = [.init(id: "0",  firstName: "Add", lastName: "more", avatar: "personAddIcon")] {
        didSet {
            signatoriesListView.reloadData()
        }
    }
    
    var pdfData: Data? {
        didSet {
            loadPDFData()
        }
    }
    
    var documentURL: URL? {
        didSet {
            loadPDFData()
        }
    }
    
    var onAddSignatoriesDidTap: (() -> ())?
    
    //MARK: - View
    private lazy var signatoriesView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Signatories"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var signatoriesListView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.dataSource = self
        view.delegate = self
        view.register(cellClass: PreviewSignatoriesCell.self)
        view.register(cellClass: PreviewAddSignatoriesCell.self)
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.149, green: 0.157, blue: 0.259, alpha: 0.12)
        return view
    }()
    
    private lazy var pdfView: PDFView = {
        let view = PDFView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isHidden = true
        return view
    }()
    
    private lazy var webView: WKWebView = {
         let webConfig = WKWebViewConfiguration()
         let view = WKWebView(frame: .zero, configuration: webConfig)
         view.backgroundColor = .white
         view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         view.navigationDelegate = self
         view.isHidden = true
         return view
     }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadDocument()
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setup() {
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        [signatoriesView,
         separatorView,
         pdfView,
         webView].forEach {
            addSubview($0)
        }
        
        [titleLabel, signatoriesListView].forEach {
            signatoriesView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        signatoriesView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/7.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(12)
            make.bottom.equalTo(signatoriesListView.snp.top).offset(-4)
            make.trailing.equalToSuperview()
        }
        
        signatoriesListView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(4)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(signatoriesView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        pdfView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
    }
    
    private func loadDocument() {
        if let documentURL = documentURL {
            if documentURL.pathExtension.lowercased() == "pdf" {
                loadPDFDocument(url: documentURL)
            } else {
                loadWebDocument(url: documentURL)
            }
        } else if let pdfData = pdfData {
            loadPDFDocument(data: pdfData)
        }
    }

       private func loadPDFDocument(url: URL) {
           let pdfDocument = PDFDocument(url: url)
           pdfView.document = pdfDocument
           showPDFView()
       }

       private func loadPDFDocument(data: Data) {
           let pdfDocument = PDFDocument(data: data)
           pdfView.document = pdfDocument
           showPDFView()
       }

       private func loadWebDocument(url: URL) {
           let request = URLRequest(url: url)
           webView.load(request)
           showWebView()
       }

       private func showPDFView() {
           pdfView.isHidden = false
           webView.isHidden = true
       }

       private func showWebView() {
           pdfView.isHidden = true
           webView.isHidden = false
       }
    
    private func loadPDFData() {
        if let documentURL = documentURL {
            let pdfDocument = PDFDocument(url: documentURL)
            pdfView.document = pdfDocument
        } else if let pdfData = pdfData {
            let pdfDocument = PDFDocument(data: pdfData)
            pdfView.document = pdfDocument
        }
    }
}

//MARK: - UITableViewDataSource
extension PreviewView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signatoriesList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < signatoriesList.count {
            let model = signatoriesList[indexPath.row]
            let cell: PreviewSignatoriesCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: model)
            return cell
        } else {
            let cell: PreviewAddSignatoriesCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.onAddSignatoriesDidTap = { [weak self] in
                self?.onAddSignatoriesDidTap?()
                self?.signatoriesListView.reloadData()
            }
            return cell
        }
    }
    
    
}

//MARK: - UITableViewDeleagate
extension PreviewView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 84)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if signatoriesList[indexPath.row] == signatoriesList.last {
            onAddSignatoriesDidTap?()
        }
    }
}

extension PreviewView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if url.pathExtension.lowercased() == "pdf" {
//                let response = URLResponse(url: url, mimeType: "application/pdf", expectedContentLength: 0, textEncodingName: nil)
                decisionHandler(.allow)
                return
            } else {
                decisionHandler(.allow)
                return
            }
        }
        
        decisionHandler(.cancel)
    }
}

extension PreviewView {
    func createTemporaryFileURL(data: Data, fileExtension: String) -> URL? {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        
        let uniqueFileName = UUID().uuidString + "." + fileExtension
        
        let temporaryFileURL = temporaryDirectory.appendingPathComponent(uniqueFileName)
        
        do {
            try data.write(to: temporaryFileURL)
            return temporaryFileURL
        } catch {
            print("Error creating temporary file: \(error.localizedDescription)")
            return nil
        }
    }
}


extension WKWebView {
    private static var urlKey: UInt8 = 0

    var url: URL? {
        get {
            return objc_getAssociatedObject(self, &WKWebView.urlKey) as? URL
        }
        set {
            objc_setAssociatedObject(self, &WKWebView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
