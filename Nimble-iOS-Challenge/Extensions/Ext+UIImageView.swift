//
//  Ext+UIImageView.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation
import UIKit

public extension UIImageView {
    func loadImage(fromURL url: String, defaultImg: String = "default_profile") {
        guard let imageURL = URL(string: url) else {
            DispatchQueue.main.async {
                self.image = UIImage(named: defaultImg)
            }
            return
        }
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.transition(toImage: image)
            }
        } else {
            self.image = UIImage(named: defaultImg)
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        self.transition(toImage: image)
                    }
                }
            }).resume()
        }
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            DispatchQueue.main.async {
                                self.image = image
                            }
                          },
                          completion: nil)
    }
}
