//
//  SignupPresenter.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation


class SignupPresenter {

    // MARK: Properties

    weak var view: SignupViewProtocol?
    var router: SignupRouterProtocol?
    var interactor: SignupInteractorInputProtocol?
}

extension SignupPresenter: SignupPresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
}

extension SignupPresenter: SignupInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
