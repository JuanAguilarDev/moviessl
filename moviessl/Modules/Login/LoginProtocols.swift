//
//  LoginProtocols.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation

protocol LoginViewProtocol: BaseViewProtocol {
    // PRESENTER -> VIEW
    
    var presenter: LoginPresenterProtocol? { get set }
}

protocol LoginRouterProtocol: BaseRouterProtocol  {
    // PRESENTER -> ROUTER
    
    static func createLoginModule() -> LoginViewController
}

protocol LoginPresenterProtocol: BasePresenterProtocol  {
    // VIEW -> PRESENTER
    
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var router: LoginRouterProtocol? { get set }
}

protocol LoginInteractorOutputProtocol: BaseInteractorOutputProtocol {
    //INTERACTOR -> PRESENTER
}

protocol LoginInteractorInputProtocol: BaseInteractorInputProtocol {
    //PRESENTER -> INTERACTOR
    
    var presenter: LoginInteractorOutputProtocol? { get set }
    var provider: WebServicesManagerCredit2Protocol? { get set }

}
