//
//  DetailsViewController.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//
//

import Foundation
import UIKit
import MaterialComponents
import WebKit

class DetailsViewController: BaseViewController {
    
    // MARK: Properties
    var presenter: DetailsPresenterProtocol?
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var goToWebPage: MDCButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var goToView: UIView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    @IBAction func goToWeb(_ sender: Any) {
        guard let presenter = self.presenter, let model = presenter.model else { return }
        
        let webVC = WebModal()
        webVC.urlString = Utils.shared.imdbUrl+"\(model.externals ?? "")"
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true, completion: nil)
    }
    
    // MARK: Custom functions
    func htmlToText(htmlText: String) -> NSMutableAttributedString {
        
        let fontSize: CGFloat = 15.0
        
        var mutableAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        if let attributedString = try? NSAttributedString(data: htmlText.data(using: .utf8)!,
                                                          options: [.documentType: NSAttributedString.DocumentType.html],
                                                          documentAttributes: nil) {
            
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize), range: NSRange(location: 0, length: mutableAttributedString.length))
            
        }
        
        return mutableAttributedString
    }
    
}


extension DetailsViewController : DetailsViewProtocol{
    // TODO: implement view output methods
    
    func setHeader(title: String) {
        let header = HeaderView()
        header.setTitle(title: title)
        
        mainStack.insertArrangedSubview(header, at: 0)
        mainStack.layoutIfNeeded()
    }
    
    func initView() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.tintColor = UIColor.white
        goToWebPage.layer.cornerRadius = 5
    }
    
    func fillElements() {
        guard let presenter = self.presenter, let model = presenter.model else { return }
        
        
        let imageAppereance = UIImageView.Appeareance(imageSource: model.image)
        showImage.setup(appearance: imageAppereance)
        
        statusLabel.text = model.status
        runtimeLabel.text = "\(model.runtime ?? 0)"
        languageLabel.text = model.language
        ratingLabel.text = "\(model.rating ?? 0)/10"
        
        if let attributedString = try? NSAttributedString(data: model.summary!.data(using: .utf8)!,
                                                          options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                          documentAttributes: nil) {
            summaryLabel.attributedText = attributedString
        }
        
        if let externals = model.externals {
            goToView.isHidden = false
        } else {
            goToView.isHidden = true
        }
        
    }
}
