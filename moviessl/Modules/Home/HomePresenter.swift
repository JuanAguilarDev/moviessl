//
//  HomePresenter.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation


class HomePresenter {

    // MARK: Properties

    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    var interactor: HomeInteractorInputProtocol?
    var shows: [ShowModel]?
}

extension HomePresenter: HomePresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.setupBackgroundView()
        view?.setHeader()
        view?.initView()
    }
    
    func viewWillAppear() {
        interactor?.getShows()
        view?.setNavigationControllerHidden(isHidden: true)
    }
    
    func updateFavorite(position: Int?, value: Bool?) {
        guard let position = position else {
            return
        }
        
        shows?[position].isFavorite = value ?? false
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func updateModel(shows: [ShowModel]?) {
        if let shows = shows {
            self.shows = shows
            view?.registerCells()
        } else {
            print("No data")
        }
    }
}
