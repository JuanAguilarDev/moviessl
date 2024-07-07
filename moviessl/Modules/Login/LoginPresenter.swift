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
        router?.goToSignupView(fromView: view)
    }
    
    func authUser(username: String, password: String) {
        view?.showLoader()
        router?.goToHomeView(fromView: view)
        //interactor?.authUser(username: username, password: password)
    }
    
    func goToHomeView(model: LoginModel?) {
        view?.hideLoader()
        
        if let model = model, let router = router {
            Utils.shared.newUser(model: model)
            router.goToHomeView(fromView: view)
        } else {
            let title = "Take a look!"
            let message = Utils.shared.loginError
            view?.showAlert(title: title, message: message)
        }
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
