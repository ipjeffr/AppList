//
//  AppListService.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-26.
//  Copyright © 2018 nil. All rights reserved.
//

import Foundation

struct AppListService: Decodable {
    let feed: Feed
    
    struct Feed: Decodable {
        let apps: [AppService]
        
        enum CodingKeys: String, CodingKey {
            case apps = "entry"
        }
        
        struct AppService: Decodable {
            let titleDict: Label
            let imageUrlArray: [ImageUrlDict]
            let bundleIdDict: BundleIdDict
            let releaseDateDict: ReleaseDateDict
            let summary: Label
            let priceDict: PriceDict
            let category: CategoryDict
            let publisherDict: PublisherDict
            
            enum CodingKeys: String, CodingKey {
                case titleDict = "im:name"
                case imageUrlArray = "im:image"
                case bundleIdDict = "id"
                case releaseDateDict = "im:releaseDate"
                case summary
                case priceDict = "im:price"
                case category
                case publisherDict = "im:artist"
            }
            
            struct Label: Decodable {
                let label: String
            }
            
            struct ImageUrlDict: Decodable {
                let label: URL
                let attributes: ImageHeight
                
                struct ImageHeight: Decodable {
                    let height: String
                }
            }
            
            struct BundleIdDict: Decodable {
                let label: URL
                let attributes: BundleId
                
                struct BundleId: Decodable {
                    let id: String
                    enum CodingKeys: String, CodingKey {
                        case id = "im:bundleId"
                    }
                }
            }
            
            struct ReleaseDateDict: Decodable {
                let date: Date
                enum CodingKeys: String, CodingKey {
                    case date = "label"
                }
            }
            
            struct PriceDict: Decodable {
                let label: String
                let attributes: Currency
                
                struct Currency: Decodable {
                    let currency: String
                }
            }
            
            struct CategoryDict: Decodable {
                let attributes: Label
            }
            
            struct PublisherDict: Decodable {
                let label: String
                let attributes: PublisherUrl
                
                struct PublisherUrl: Decodable {
                    let href: URL
                }
            }
        }
    }
}
