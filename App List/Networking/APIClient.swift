//
//  APIClient.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-24.
//  Copyright © 2018 nil. All rights reserved.
//

import Foundation

fileprivate struct URLs {
    static let appsURL = "http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=100/json"
}

enum AppsResult {
    case success([App])
    case error
}

struct APIClient {
    
    private static let session = URLSession(configuration: .default)
    enum DateError: String, Error {
        case invalidDate
    }
    static func fetchPaidApps(completion: @escaping (AppsResult) -> Void) {
        guard let url = URL(string: URLs.appsURL) else { return }
        let task = session.dataTask(with: url) {
            (data, response, error) in
            
            guard let responseData = data else {
                completion(.error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            do {
                let appListService = try decoder.decode(AppListService.self, from: responseData)
                
                let appList = AppList(from: appListService)
                
                for app in appList.apps {
                    let string = app.publisher + " " + String(describing: app.publisherUrl) + "\n\n"
                    debugPrint(string)
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}

//let formatter = DateFormatter()
//formatter.dateFormat = "MM/dd/YYYY"
//let string = formatter.string(from: appList.apps[0].releaseDate)
//print(string)
