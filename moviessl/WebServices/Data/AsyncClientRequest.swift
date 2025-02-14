//
//  AsyncClientRequest.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//


import Foundation
import Alamofire
import ObjectMapper

class AsyncClientRequest {
    static let successCode: Int = 200
    static let errorCode: Int = 404
    
    static var shared = AsyncClientRequest()
    
    var params: Parameters = [:]
    var encoding: ParameterEncoding = URLEncoding.default
    var baseURL: String = "https://api.tvmaze.com/"
    var baseLoginURL: String = "https://todo-app-bmna.onrender.com/api/"
    
    func callServiceInternal<T: Mappable>(requestModel: AsyncClientMoviesRequestModel, completion: @escaping (Result<T, Error>?) -> Void) {
        
        var url = self.getLoginUrl(requestModel: requestModel) 
        let method = requestModel.httpMethod.getMethod()
        let headers = requestModel.headers
        
        if let key = requestModel.key1, url.contains(":key1") {
            url = url.replacingOccurrences(of: ":key1", with: key)
        }
        
        if let key = requestModel.key2, url.contains(":key2") {
            url = url.replacingOccurrences(of: ":key2", with: key)
        }
        
        if let bodyParams = requestModel.bodyParams {
            for param in bodyParams {
                params[param.key] = param.value
            }
            encoding = JSONEncoding.default
        }
        
        
        AF.request(url, method: method, parameters: params, encoding: encoding, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data else {
                    completion(.failure(NSError(domain: "", code: 500)))
                    return
                }
                
                if let parsedObject = Mapper<T>().map(JSONString: String(data: jsonData, encoding: .utf8)!) {
                    completion(.success(parsedObject))
                } else {
                    completion(.failure(NSError(domain: "", code: 500)))
                }
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
        
    }
    
    // Arrays
    
    func callServiceForArray<T: Mappable>(requestModel: AsyncClientMoviesRequestModel, completion: @escaping (Result<[T], Error>?) -> Void) {
        var url = self.getUrl(requestModel: requestModel)
        let method = requestModel.httpMethod.getMethod()
        let headers = requestModel.headers
        
        if let key = requestModel.key1, url.contains(":key1") {
            url = url.replacingOccurrences(of: ":key1", with: key)
        }
        
        if let key = requestModel.key2, url.contains(":key2") {
            url = url.replacingOccurrences(of: ":key2", with: key)
        }
        
        if let bodyParams = requestModel.bodyParams {
            for param in bodyParams {
                params[param.key] = param.value
            }
            encoding = JSONEncoding.default
        }
        
        
        AF.request(url, method: method, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data else {
                    completion(.failure(NSError(domain: "", code: 500)))
                    return
                }
                
                if let parsedObject = Mapper<T>().mapArray(JSONString: String(data: jsonData, encoding: .utf8)!) {
                    completion(.success(parsedObject))
                } else {
                    completion(.failure(NSError(domain: "", code: 500)))
                }
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }

    }
    
    
    func getUrl(requestModel: AsyncClientMoviesRequestModel) -> String {
        return ("\(baseURL)\(requestModel.service.getPath())")
    }
    
    func getLoginUrl(requestModel: AsyncClientMoviesRequestModel) -> String {
        return ("\(baseLoginURL)\(requestModel.service.getPath())")
    }
    
}


