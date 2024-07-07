//
//  SignupInteractor.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation

class SignupInteractor {

    // MARK: Properties

    weak var presenter: SignupInteractorOutputProtocol?
    var provider: MoviesServicesManagerProtocol?

}

extension SignupInteractor: SignupInteractorInputProtocol {
    // TODO: Implement use case methods
    func signUpUser(name: String, username: String, password: String) {
        
    }
    
}
