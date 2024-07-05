//
//  LoginRouter.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation
import UIKit

class LoginRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createLoginModule() -> LoginViewController {
        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        
        let interactor: LoginInteractorInputProtocol = LoginInteractor()
        
        let router: LoginRouterProtocol = LoginRouter()
        
        let provider: MoviesServicesManagerProtocol = MoviesServicesManager()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.provider = provider
        
        return view
    }
}

extension LoginRouter: LoginRouterProtocol {
    // TODO: Implement wireframe methods
}
