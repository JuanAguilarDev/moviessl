//
//  SignupProtocols.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation

protocol SignupViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: SignupPresenterProtocol? { get set }
}

protocol SignupRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createSignupModule() -> SignupViewController
}

protocol SignupPresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: SignupViewProtocol? { get set }
    var interactor: SignupInteractorInputProtocol? { get set }
    var router: SignupRouterProtocol? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
}

protocol SignupInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
}

protocol SignupInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: SignupInteractorOutputProtocol? { get set }
    var provider: MoviesServicesManagerProtocol? { get set }

}
