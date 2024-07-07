//
//  MoviesServicesManagerProtocol.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//

import Foundation


protocol MoviesServicesManagerProtocol : AnyObject {
    
    func getShows(_ completion: @escaping ([Show]) -> Void)
    
    func signUpUser(username: String, password: String, name: String, _ completion: @escaping (LoginEntity) -> Void)
    
    func authUser(username: String, password: String, _ completion: @escaping (LoginEntity) -> Void)
    
}
