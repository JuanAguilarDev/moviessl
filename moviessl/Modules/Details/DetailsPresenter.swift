//
//  DetailsPresenter.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation


class DetailsPresenter {

    // MARK: Properties

    weak var view: DetailsViewProtocol?
    var router: DetailsRouterProtocol?
    var interactor: DetailsInteractorInputProtocol?
    var model: ShowModel?
    
    init(model: ShowModel? = nil) {
        self.model = model
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.setHeader(title: model?.name ?? "Show")
        view?.setupBackgroundView()
        view?.setNavigationControllerHidden(isHidden: false)
        view?.initView()
        view?.fillElements()
    }
    
    func viewWillAppear() {
        
    }
}

extension DetailsPresenter: DetailsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
