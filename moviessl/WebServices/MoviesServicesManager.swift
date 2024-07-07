//
//  MoviesServicesManager.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//

import Foundation
import Alamofire
import ObjectMapper

class MoviesServicesManager : MoviesServicesManagerProtocol {
    // MARK: Implementation of functions
    
    let concurrentQueve = DispatchQueue(label: "services", attributes: .concurrent)
    
    
    // MARK: Get Shows
    func getShows(_ completion: @escaping ([Show]) -> Void) {
        let requestModel = AsyncClientMoviesRequestModel.RequestModelBuilder()
            .service(service: .GET_SHOWS)
            .httpMethod(httpMethod: .GET)
            .build()
        
        self.callServiceForArray(requestModel: requestModel) { (dataResponse: [Show]?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    // MARK: SIGNUP
    func signUpUser(username: String, password: String, name: String, _ completion: @escaping (LoginEntity) -> Void) {
        let params: Parameters = [
            "password": password,
            "username": username,
            "name": name
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let requestModel = AsyncClientMoviesRequestModel.RequestModelBuilder()
            .service(service: .SIGN_UP)
            .bodyParams(bodyParams: params)
            .httpMethod(httpMethod: .POST)
            .headers(httpHeader: headers)
            .build()
        
        self.callService(requestModel: requestModel) { (dataResponse: LoginEntity?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    
    
    
    
    // MARK: AUTH
    func authUser(username: String, password: String, _ completion: @escaping (LoginEntity) -> Void) {
        let params: Parameters = [
            "password": password,
            "username": username
        ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json",
        ]
        
        let requestModel = AsyncClientMoviesRequestModel.RequestModelBuilder()
            .service(service: .AUTH_USER)
            .bodyParams(bodyParams: params)
            .httpMethod(httpMethod: .POST)
            .headers(httpHeader: headers)
            .build()
        
        self.callService(requestModel: requestModel) { (dataResponse: LoginEntity?) in
            if let data = dataResponse {
                completion(data)
            }
        }
    }
    

    // MARK: Custom functions
    private func callService<T:Mappable>(requestModel: AsyncClientMoviesRequestModel, successBlock: @escaping(_ dataResponse: T?) -> Void){
        concurrentQueve.async {
            AsyncClientRequest.shared.callServiceInternal(requestModel: requestModel) { (result: Result<T, Error>?) in
                switch result {
                case .success(let data):
                    successBlock(data)
                case .failure(_):
                    return
                case .none:
                    return
                }
            }
        }
    }
    
    private func callServiceForArray<T:Mappable>(requestModel: AsyncClientMoviesRequestModel, successBlock: @escaping(_ dataResponse: [T]?) -> Void){
        concurrentQueve.async {
            AsyncClientRequest.shared.callServiceForArray(requestModel: requestModel) { (result: Result<[T], Error>?) in
                switch result {
                case .success(let data):
                    successBlock(data)
                case .failure(_):
                    return
                case .none:
                    return
                }
            }
        }
    }
    
}
    
    

