//
//  LoginProtocols.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation

protocol LoginViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: LoginPresenterProtocol? { get set }
}

protocol LoginRouterProtocol: Any  {
    // PRESENTER -> ROUTER
    
    static func createLoginModule() -> LoginViewController
}

protocol LoginPresenterProtocol: Any  {
    // VIEW -> PRESENTER
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
}

protocol LoginInteractorOutputProtocol: Any {
    //INTERACTOR -> PRESENTER
}

protocol LoginInteractorInputProtocol: Any {
    //PRESENTER -> INTERACTOR
    
    var presenter: LoginInteractorOutputProtocol? { get set }
    var provider: MoviesServicesManagerProtocol? { get set }

}
