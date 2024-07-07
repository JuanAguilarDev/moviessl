//
//  HomeRouter.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation
import UIKit

class HomeRouter {

    // MARK: Properties


    // MARK: Static methods

    static func createHomeModule() -> HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        
        let interactor: HomeInteractorInputProtocol = HomeInteractor()
        
        let router: HomeRouterProtocol = HomeRouter()
        
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

extension HomeRouter: HomeRouterProtocol {
    // TODO: Implement wireframe methods
    
    func goToDetailView(fromView: BaseViewController?, model: ShowModel) {
        if let view = fromView {
            let detailView = DetailsRouter.createDetailsModule(model: model)
            view.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}
