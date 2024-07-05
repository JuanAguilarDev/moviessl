//
//  SignupViewController.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation
import UIKit

class SignupViewController: BaseViewController {

    // MARK: Properties
    var presenter: SignupPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}


extension SignupViewController : SignupViewProtocol{
    // TODO: implement view output methods
}
