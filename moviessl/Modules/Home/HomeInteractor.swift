//
//  HomeInteractor.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//  
//

import Foundation

class HomeInteractor {

    // MARK: Properties

    weak var presenter: HomeInteractorOutputProtocol?
    var provider: MoviesServicesManagerProtocol?

}

extension HomeInteractor: HomeInteractorInputProtocol {
    // TODO: Implement use case methods
    
    func getShows() {
        provider?.getShows({ [weak self] data in
            guard let self = self else { return }
            
            if !data.isEmpty {
                var model: [ShowModel] = []
                
                for show in data {
                    
                    let showImage = ImageSource.remoteImage(imageURL: show.image?.medium ?? "", fallbackImage: "photo")
                    
                    let newShow = ShowModel(id: show.id, url: show.url, name: show.name, type: show.type, language: show.language, genres: show.genres, status: show.status, runtime: show.runtime, premiered: show.premiered, ended: show.ended, officialSite: show.officialSite, rating: show.rating?.average, image: showImage, summary: show.summary, externals: show.externals?.imdb)
                    model.append(newShow)
                }
                
                self.presenter?.updateModel(shows: model)
            } else {
                self.presenter?.updateModel(shows: nil)
            }
        })
    }
}
