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
    var status: Bool?
    
    init(model: ShowModel? = nil) {
        self.model = model
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.setHeader(title: model?.name ?? "Show", model: model)
        view?.setupBackgroundView()
        view?.setNavigationControllerHidden(isHidden: false)
        view?.initView()
        view?.fillElements()
    }
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
}

extension DetailsPresenter: DetailsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
