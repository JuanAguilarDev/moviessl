//
//  LoginPresenter.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//  
//

import Foundation


class LoginPresenter {

    // MARK: Properties

    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol?
    var interactor: LoginInteractorInputProtocol?
}

extension LoginPresenter: LoginPresenterProtocol {
    // TODO: implement presentation methods
    
    func goToSignUpView(){
        // router?.goToSignupView(fromView: view)
    }
    
    func showBlanksError() {
        let title = "Wait"
        let message = Utils.shared.fillBlanks
        view?.showAlert(title: title, message: message)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
