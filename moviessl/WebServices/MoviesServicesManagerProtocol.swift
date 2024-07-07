//
//  MoviesServicesManagerProtocol.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//

import Foundation


protocol MoviesServicesManagerProtocol : AnyObject {
    
    func getShows(_ completion: @escaping ([Show]) -> Void)
}
