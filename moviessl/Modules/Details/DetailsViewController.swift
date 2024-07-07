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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
        if self.isMovingFromParent {
            if let presenter = presenter, let status = presenter.status {
                if status {
                    let element = DatabaseManager.shared.getAllShows().filter { $0.id == presenter.model?.id }
                    
                    if let model = presenter.model, element.isEmpty {
                        model.isFavorite = true
                        DatabaseManager.shared.insertShow(show: model)
                    }
                } else {
                    let element = DatabaseManager.shared.getAllShows().filter { $0.id == presenter.model?.id }
                    
                    if let model = presenter.model, let id = model.id, !element.isEmpty {
                        DatabaseManager.shared.deleteShow(id: id)
                    }
                }
            }
        }
    }
    
    @IBAction func goToWeb(_ sender: Any) {
        guard let presenter = self.presenter, let model = presenter.model else { return }
        
        let webVC = WebModal()
        webVC.urlString = Utils.shared.imdbUrl+"\(model.externals ?? "")"
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true, completion: nil)
    }
    
    // MARK: Custom functions
    
}


extension DetailsViewController : DetailsViewProtocol{
    // TODO: implement view output methods
    
    func setHeader(title: String, model: ShowModel?) {
        let header = HeaderView()
        header.delegate = self
        header.setTitle(title: title)
        
        let element = DatabaseManager.shared.getAllShows().filter { $0.id == model?.id }
        
        if !element.isEmpty {
            header.setFavoriteView(isFavorite: element[0].isFavorite ?? true)
        } else {
            header.setFavoriteView(isFavorite: false)
        }
        
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
        
        if let _ = model.externals {
            goToView.isHidden = false
        } else {
            goToView.isHidden = true
        }
        
    }
}


extension DetailsViewController: HeaderViewProtocol {
    func onClickBtn(status: Bool) {
        presenter?.status = status
    }
}
