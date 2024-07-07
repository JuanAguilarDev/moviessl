//
//  DetailsRouter.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation
import UIKit

class DetailsRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createDetailsModule(model: ShowModel) -> DetailsViewController {
        let view = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        
        let presenter: DetailsPresenterProtocol & DetailsInteractorOutputProtocol = DetailsPresenter(model: model)
        
        let interactor: DetailsInteractorInputProtocol = DetailsInteractor()
        
        let router: DetailsRouterProtocol = DetailsRouter()
        
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

extension DetailsRouter: DetailsRouterProtocol {
    // TODO: Implement wireframe methods
}
