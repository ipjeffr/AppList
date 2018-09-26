//
//  AppList.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-26.
//  Copyright © 2018 nil. All rights reserved.
//

import Foundation

enum IconSize: Int {
    case small = 0 // 53x53
    case medium // 75x75
    case large // 100x100
}

struct AppList {
    let apps: [App]
    
    init(from service: AppListService) {
        var appsTemp: [App] = []
        for app in service.feed.apps {
            let title = app.titleDict.label
            let iconUrl = app.iconUrlArray[IconSize.large.rawValue].label
            let bundleId = app.bundleIdDict.attributes.id
            let releaseDate = app.releaseDateDict.date
            let summary = app.summary.label
            let price = app.priceDict.label
            let currency = app.priceDict.attributes.currency
            let category = app.category.attributes.label
            let storeUrl = app.bundleIdDict.label
            let publisher = app.publisherDict.label
            let publisherUrl = app.publisherDict.attributes.href
            
            let newApp = App(title: title,
                             iconUrl: iconUrl,
                             bundleId: bundleId,
                             releaseDate: releaseDate,
                             summary: summary,
                             price: price,
                             currency: currency,
                             category: category,
                             storeUrl: storeUrl,
                             publisher: publisher,
                             publisherUrl: publisherUrl)
            
            appsTemp.append(newApp)
        }
        self.apps = appsTemp
    }
}

struct App {
    let title: String
    let iconUrl: URL
    let bundleId: String
    let releaseDate: Date
    let summary: String
    let price: String
    let currency: String
    let category: String
    let storeUrl: URL
    let publisher: String
    let publisherUrl: URL
}
