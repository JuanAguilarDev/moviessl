//
//  DetailsInteractor.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation

class DetailsInteractor {

    // MARK: Properties

    weak var presenter: DetailsInteractorOutputProtocol?
    var provider: MoviesServicesManagerProtocol?

}

extension DetailsInteractor: DetailsInteractorInputProtocol {
    // TODO: Implement use case methods
}
