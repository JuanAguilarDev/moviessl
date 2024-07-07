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
        interactor?.getShows()
        view?.setupBackgroundView()
        view?.setHeader()
        view?.initView()
    }
    
    func viewWillAppear() {
        view?.setNavigationControllerHidden(isHidden: true)
        updateFavorite()
    }
    
    func updateFavorite() {
        favoriteShows = DatabaseManager.shared.getAllShows()
        if let favoriteShows = favoriteShows {
            for favorite in favoriteShows {
                favorite.isFavorite = true
                let showImage = ImageSource.remoteImage(imageURL: favorite.imageUrl ?? "", fallbackImage: "photo")
                
                favorite.image = showImage
            }
        }
        
        updateShows()
    }
    
    func updateShows() {
        favoriteShows = DatabaseManager.shared.getAllShows()
        if let favoriteShows = favoriteShows, let shows = shows {
            for favorite in favoriteShows {
                favorite.isFavorite = true
                let showImage = ImageSource.remoteImage(imageURL: favorite.imageUrl ?? "", fallbackImage: "photo")
                
                favorite.image = showImage
            }
            
            if !favoriteShows.isEmpty {
                for show in shows {
                    show.isFavorite = false
                }
            }
            
            for favorite in favoriteShows {
                for (index, show) in shows.enumerated() {
                    if favorite.id == show.id {
                        shows[index].isFavorite = true
                    }
                }
            }
            
            if favoriteShows.isEmpty {
                for show in shows {
                    show.isFavorite = false
                }
            }
        }
        
        view?.reloadTable()
    }
    
    func goToDetailView(show: ShowModel?) {
        if let show = show {
            router?.goToDetailView(fromView: self.view, model: show)
        } else {
            return
        }
    }
    
    func updateIsFavorite() {
        if let shows = shows {
            for element in DatabaseManager.shared.getAllShows() {
                for (index, show) in shows.enumerated() {
                    if element.id == show.id {
                        shows[index].isFavorite = true
                    }
                }
            }
            
            if DatabaseManager.shared.getAllShows().isEmpty {
                for element in shows {
                    element.isFavorite = false
                }
            }
            
            self.updateFavorite()
            self.shows = shows
        }
    }
    
    func addFavorite(favorite: ShowModel?, id: Int?){
        guard let favorite = favorite, let id = id else {
            return
        }
        
        shows?[id].isFavorite = true
        favorite.isFavorite = true
        DatabaseManager.shared.insertShow(show: favorite)
        updateFavorite()
    }
    
    func removeFavorite(id: Int?, position: Int?) {
        guard let id = id, let position = position else {
            return
        }
        
        shows?[position].isFavorite = false
        DatabaseManager.shared.deleteShow(id: id)
        updateFavorite()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func updateModel(shows: [ShowModel]?) {
        if let shows = shows {
            self.shows = shows
            updateFavorite()
            view?.registerCells()
        } else {
            print("No data")
        }
    }
}
