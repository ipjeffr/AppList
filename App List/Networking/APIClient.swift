//
//  APIClient.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-24.
//  Copyright © 2018 nil. All rights reserved.
//

import UIKit

fileprivate struct URLs {
    static let appsURL = "http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=100/json"
}

enum AppListResult {
    case success([App])
    case failure(Error)
}

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

struct APIClient {
    
    private let session = URLSession(configuration: .default)
    private let imageStore = ImageStore()
    
    func fetchPaidAppList(completion: @escaping (AppListResult) -> Void) {
        guard let url = URL(string: URLs.appsURL) else { return }
        let task = session.dataTask(with: url) {
            (data, response, error) in
            
            guard let responseData = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let appListService = try decoder.decode(AppListService.self, from: responseData)
                
                let appList = AppList(from: appListService)
                
                DispatchQueue.main.async {
                    completion(.success(appList.apps))
                }
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchImage(for app: App, completion: @escaping (ImageResult) -> Void) {
        
        let appKey = app.bundleId
        if let image = imageStore.image(forKey: appKey) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        
        let iconUrl = app.iconUrl
        let request = URLRequest(url: iconUrl)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: appKey)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard let imageData = data,
            let image = UIImage(data: imageData) else {
                return .failure(error!)
        }
        return .success(image)
    }
}
