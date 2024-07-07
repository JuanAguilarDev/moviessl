//
//  LoginInteractor.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation

class LoginInteractor {

    // MARK: Properties

    weak var presenter: LoginInteractorOutputProtocol?
    var provider: MoviesServicesManagerProtocol?

}

extension LoginInteractor: LoginInteractorInputProtocol {
    // TODO: Implement use case methods
    func authUser(username: String, password: String) {
        
    }
}
