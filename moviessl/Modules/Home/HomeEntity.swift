//
//  HomeEntity.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import Foundation
import ObjectMapper

class Show: Mappable {
    var id: Int?
    var url: String?
    var name: String?
    var type: String?
    var language: String?
    var genres: [String]?
    var status: String?
    var runtime: Int?
    var premiered: String?
    var ended: String?
    var officialSite: String?
    var rating: Rate?
    var image: ShowImage?
    var summary: String?
    var externals: External?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        name <- map["name"]
        type <- map["type"]
        language <- map["language"]
        genres <- map["genres"]
        status <- map["status"]
        runtime <- map["runtime"]
        premiered <- map["premiered"]
        ended <- map["ended"]
        officialSite <- map["officialSite"]
        rating <- map["rating"]
        image <- map["image"]
        summary <- map["summary"]
        externals <- map["externals"]
    }
}

class Rate: Mappable {
    var average: Int?
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        average <- map["average"]
    }
}

class External: Mappable {
    var imdb: String?
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        imdb <- map["imdb"]
    }
}

class ShowImage: Mappable {
    var medium: String?
    var original: String?
    
    required init?(map: Map){ }
    
    func mapping(map: Map) {
        medium <- map["medium"]
        original <- map["original"]
    }
}

// MARK: Models - Responsability

class ShowModel {
    var id: Int?
    var userId: String?
    var url: String?
    var name: String?
    var type: String?
    var language: String?
    var genres: [String]?
    var status: String?
    var runtime: Int?
    var premiered: String?
    var ended: String?
    var officialSite: String?
    var rating: Int?
    var image: ImageSource?
    var summary: String?
    var isFavorite: Bool?
    var externals: String?
   
    init(id: Int? = nil, url: String? = nil, name: String? = nil, type: String? = nil, language: String? = nil, genres: [String]? = nil, status: String? = nil, runtime: Int? = nil, premiered: String? = nil, ended: String? = nil, officialSite: String? = nil, rating: Int? = nil, image: ImageSource? = nil, summary: String? = nil, externals: String? = nil) {
        self.id = id
        self.url = url
        self.name = name
        self.type = type
        self.language = language
        self.genres = genres
        self.status = status
        self.runtime = runtime
        self.premiered = premiered
        self.ended = ended
        self.officialSite = officialSite
        self.rating = rating
        self.image = image
        self.summary = summary
        self.externals = externals
    }
}
