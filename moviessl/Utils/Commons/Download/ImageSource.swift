//
//  ImageSource.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import Foundation
import UIKit


enum ImageSource {
    case localImage(image: String)
    case remoteImage(imageURL: String, fallbackImage: String?)
}

extension UIImageView {
    struct Appeareance {
        let imageSource: ImageSource?
        let isHidden: Bool?
        
        init(imageSource: ImageSource? = nil, isHidden: Bool? = false) {
            self.imageSource = imageSource
            self.isHidden = isHidden
        }
    }
    
    func setup(appearance: UIImageView.Appeareance) {
        if let isHidden = appearance.isHidden {
            self.isHidden = isHidden
        }
        
        if let imageSource = appearance.imageSource {
            switch imageSource {
            case .localImage(let image):
                self.image = UIImage(named: image)
            case .remoteImage(let imageURL, let fallbackImage):
                DownloadImageService(url: imageURL).fetch { result in
                    switch result {
                    case .success(let image):
                        self.image = image
                    case .failure:
                        self.image = UIImage(named: fallbackImage ?? "")
                    }
                }
            }
        }
    }
}

// MARK: - Setup downloaded image and adjust constraint height
extension UIImageView {
    private func setup(appearance: UIImageView.Appeareance, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let isHidden = appearance.isHidden {
            self.isHidden = isHidden
        }
        
        if let imageSource = appearance.imageSource {
            switch imageSource {
            case .localImage(let image):
                self.image = UIImage(named: image)
            case .remoteImage(let imageURL, let fallbackImage):
                DownloadImageService(url: imageURL).fetch { result in
                    switch result {
                    case .success(let image):
                        self.image = image
                        completion(.success(image))
                    case .failure:
                        self.image = UIImage(named: fallbackImage ?? "")
                        completion(.failure(DownloadImageService.DownloadImageError.networkErrorOrInvalidURL))
                    }
                }
            }
        } else {
            completion(.failure(DownloadImageService.DownloadImageError.networkErrorOrInvalidURL))
        }
    }
    
    func setup(appearance: UIImageView.Appeareance, heightImage: NSLayoutConstraint) {
        self.setup(appearance: appearance) { result in
            switch result {
            case .success(let image):
                let factor = self.frame.width / image.size.width
                let hSize = (factor * image.size.height)
                heightImage.constant = hSize
            default:
                break
            }
        }
    }
}

extension Optional where Wrapped == String {
    var elegantUnwrap: String {
        return self ?? ""
    }
}
