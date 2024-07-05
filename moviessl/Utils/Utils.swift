//
//  Utils.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//

import Foundation
import MaterialComponents


// MARK: Progress Loader

class ProgressLoader : UIView {
    private let progressView: MDCProgressView = {
        let progressView = MDCProgressView()
        progressView.progress = 0
        progressView.mode = .indeterminate
        progressView.trackTintColor = UIColor.clear
        progressView.progressTintColor = UIColor(hex: "ffffff")
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressView()
    }
    
    private func setupProgressView() {
        addSubview(progressView)
        progressView.frame = bounds
        progressView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func startAnimating() {
        progressView.startAnimating()
    }
    
    func stopAnimating() {
        progressView.stopAnimating()
    }
}


class BaseViewController: UIViewController {
    
    let progressLoader = ProgressLoader()
    
    func showLoader() {
        self.view.isUserInteractionEnabled = false
        progressLoader.frame = view.bounds
        view.addSubview(progressLoader)
        progressLoader.startAnimating()
    }
    
    func hideLoader() {
        self.view.isUserInteractionEnabled = true
        self.progressLoader.removeFromSuperview()
        progressLoader.stopAnimating()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = MDCAlertController(title: title, message: message)

        let action = MDCAlertAction(title: "OK") { (action) in }
        alertController.addAction(action)

        present(alertController, animated: true, completion: nil)
    }
}
