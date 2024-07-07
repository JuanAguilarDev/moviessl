//
//  DetailsProtocols.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation

protocol DetailsViewProtocol: BaseViewController {
    // PRESENTER -> VIEW
    
    var presenter: DetailsPresenterProtocol? { get set }
    
    func setHeader(title: String, model: ShowModel?)
    func initView()
    func fillElements()
}

protocol DetailsRouterProtocol: AnyObject  {
    // PRESENTER -> ROUTER
    
    static func createDetailsModule(model: ShowModel) -> DetailsViewController
}

protocol DetailsPresenterProtocol: AnyObject  {
    // VIEW -> PRESENTER
    
    var view: DetailsViewProtocol? { get set }
    var interactor: DetailsInteractorInputProtocol? { get set }
    var router: DetailsRouterProtocol? { get set }
    var model: ShowModel? { get set }
    var status: Bool? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

protocol DetailsInteractorOutputProtocol: AnyObject {
    //INTERACTOR -> PRESENTER
}

protocol DetailsInteractorInputProtocol: AnyObject {
    //PRESENTER -> INTERACTOR
    
    var presenter: DetailsInteractorOutputProtocol? { get set }
    var provider: MoviesServicesManagerProtocol? { get set }

}
