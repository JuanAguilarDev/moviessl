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
    var favoriteShows: [ShowModel]? = []
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
    
    func goToDetailView(show: ShowModel?) {
        if let show = show {
            router?.goToDetailView(fromView: self.view, model: show)
        } else {
            return
        }
    }
    
    func addFavorite(favorite: ShowModel?){
        guard let favorite = favorite else {
            return
        }
        
        self.favoriteShows?.append(favorite)
    }
    
    func removeFavorite(id: Int?) {
        guard let id = id else {
            return
        }
        
        self.favoriteShows?.removeAll {
            $0.id == id
        }
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
