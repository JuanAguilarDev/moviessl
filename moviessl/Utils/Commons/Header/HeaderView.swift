//
//  HeaderView.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import Foundation
import UIKit

protocol HeaderViewProtocol {
    func onClickBtn(status: Bool)
}

class HeaderView: UIView {
    
    // MARK: Properties
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!

    var delegate: HeaderViewProtocol?
    var status: Bool = false

    static var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 353, height: 110)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(HeaderView.identifier, owner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setTitle(title: String?) {
        self.titleLabel.text = title ?? ""
        headerView.backgroundColor = UIColor(hex: Utils.shared.mainColor)
        favoriteView.isHidden = true
    }
    
    func setFavoriteView(isFavorite: Bool) {
        favoriteView.isHidden = false
        if isFavorite {
            favoriteImage.image = UIImage(systemName: "star.fill")
            favoriteImage.tintColor = UIColor.yellow
            favoriteLabel.text = "Delete"
            status = true
        } else {
            favoriteImage.image = UIImage(systemName: "star")
            favoriteImage.tintColor = UIColor.white
            favoriteLabel.text = "Favorite"
            status = false
        }
    }
    
    @IBAction func onClickBtn(_ sender: Any) {
        setFavoriteView(isFavorite: !status)
        guard let delegate = delegate else { return }
        delegate.onClickBtn(status: status)
    }
}
