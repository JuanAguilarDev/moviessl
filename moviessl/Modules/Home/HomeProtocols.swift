//
//  HomeProtocols.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation

protocol HomeViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: HomePresenterProtocol? { get set }
    
    func setHeader()
    func registerCells()
    func initView()
}

protocol HomeRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createHomeModule() -> HomeViewController
    
    func goToDetailView(fromView: BaseViewController?, model: ShowModel) 
}

protocol HomePresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    var shows: [ShowModel]? { get set }
    var favoriteShows: [ShowModel]? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func updateFavorite(position: Int?, value: Bool?)
    func addFavorite(favorite: ShowModel?)
    func removeFavorite(id: Int?)
    func goToDetailView(show: ShowModel?)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
    
    func updateModel(shows: [ShowModel]?)
}

protocol HomeInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    var provider: MoviesServicesManagerProtocol? { get set }

    func getShows()
}
