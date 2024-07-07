//
//  WebModal.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import Foundation
import WebKit

class WebModal: UIViewController {
    
    var webView: WKWebView!
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        let closeButton = UIButton(frame: CGRect(x: 20, y: 40, width: 100, height: 50))
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
