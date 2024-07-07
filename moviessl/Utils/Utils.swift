//
//  Utils.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//

import Foundation
import MaterialComponents


class Utils {
    
    static let shared = Utils()
    var model: LoginModel?
    
    // Colors
    let mainColor = "7A3FFE"
    
    // Messages
    let loginError: String = "Ooops, it seems that the user or password does not match."
    let signUpError: String = "Ooops, we are having problems, try again later."
    let fillBlanks: String = "Ooops, all fields should be filled in."
    let connectionError: String = "Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?"
    let confirmation: String = "Are you sure you want to remove this catalog from your favorites?"
    
    // URLs
    let imdbUrl: String = "https://www.imdb.com/title/"
    
    func newUser(model: LoginModel) {
        self.model = model
    }
    
}

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
    
    func showConfirmationAlert(){
        
    }
    
    func setNavigationControllerHidden(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: isHidden)
    }
    
    func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor(hex: Utils.shared.mainColor)
        
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
