//
//  AsyncClientMoviesRequestModel.swift
//  moviessl
//
//  Created by Juan Aguilar on 05/07/24.
//

import Foundation
import Alamofire
import ObjectMapper

struct AsyncClientMoviesRequestModel {
    var service: Service = .AUTH_USER
    var httpMethod: HttpMethod = .GET
    var bodyParams: Parameters?
    var headers: HTTPHeaders?
    var key1: String?
    var key2: String?
    
    enum Service {
        case AUTH_USER
        case SIGN_UP
        case GET_SHOWS
        
        func getPath() -> String {
            switch self {
            case .AUTH_USER:
                return "auth"
            case .SIGN_UP:
                return "auth/signup"
            case .GET_SHOWS:
                return "shows"
            }
        }
    }

    enum HttpMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
        
        func getMethod() -> Alamofire.HTTPMethod {
            switch self {
            case .GET: return .get
            case .POST: return .post
            case .DELETE: return .delete
            case .PUT: return .put
            }
        }
    }
    
    class RequestModelBuilder {
        
        private var requestModel = AsyncClientMoviesRequestModel()
        
        func service(service: Service) -> RequestModelBuilder {
            requestModel.service = service
            return self
        }
        
        func httpMethod(httpMethod: HttpMethod) -> RequestModelBuilder {
            requestModel.httpMethod = httpMethod
            return self
        }
        
        func bodyParams(bodyParams: Parameters) -> RequestModelBuilder {
            requestModel.bodyParams = bodyParams
            return self
        }
        
        func build() -> AsyncClientMoviesRequestModel {
            return requestModel
        }
        
        func key1(key: String) -> RequestModelBuilder {
            requestModel.key1 = key
            return self
        }
        
        func key2(key: String) -> RequestModelBuilder {
            requestModel.key2 = key
            return self
        }
        
        func headers(httpHeader: HTTPHeaders) -> RequestModelBuilder {
            requestModel.headers = httpHeader
            return self
        }
    
    }
    
}
