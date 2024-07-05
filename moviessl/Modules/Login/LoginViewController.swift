//
//  LoginViewController.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation
import UIKit

class LoginViewController: BaseViewController {

    // MARK: Properties
    var presenter: LoginPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        initView() // STORYBOARD
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}


extension LoginViewController : LoginViewProtocol{
    // TODO: implement view output methods
    func initView() {
        self.title = "Welcome Back!"
    }
}
