//
//  HeaderView.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import Foundation
import UIKit

class HeaderView: UIView {
    
    // MARK: Properties
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var headerView: UIView!
    
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
    }
    
}
