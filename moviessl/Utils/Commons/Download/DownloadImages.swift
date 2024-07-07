//
//  DownloadImages.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import Foundation
import Alamofire

typealias DownloadImageCompletion = (Swift.Result<UIImage, Error>) -> Void

struct DownloadImageService {
    private let url: String?
    
    enum DownloadImageError: Error {
        case emptyURL
        case networkErrorOrInvalidURL
    }
    
    init(url: String?) {
        self.url = url
    }
    
    func fetch(completion: @escaping DownloadImageCompletion) {
        guard let url = url else {
            completion(.failure(DownloadImageError.emptyURL))
            return
        }
        AF.request(url, method: .get).response { response in
           if let data: Data = response.data, let image = UIImage(data: data) {
               completion(.success(image))
           } else {
               completion(.failure(DownloadImageError.networkErrorOrInvalidURL))
           }
       }
    }
}
