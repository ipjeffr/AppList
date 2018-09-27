//
//  AppListDetailCellBuilder.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-26.
//  Copyright © 2018 nil. All rights reserved.
//

import Foundation

struct AppListDetailCellBuilder {
    let app: App
    
    enum CellType: String {
        case title = "AppListDetailTitleTableViewCell"
        case summary = "AppListDetailSummaryCell"
        case releaseDate = "AppListDetailReleaseDateCell"
        case category = "AppListDetailCategoryCell"
        case publisher = "AppListDetailPublisherCell"
        
        static let allCases: [CellType] = [.title,
                                           .summary,
                                           .releaseDate,
                                           .category,
                                           .publisher]
    }
    
    func getCellCount() -> Int {
        return CellType.allCases.count
    }
    
    func getAllCases() -> [CellType] {
        return CellType.allCases
    }
    
    func getReuseIdentifier(at index: Int) -> String {
        return CellType.allCases[index].rawValue
    }
    
    func getReuseIdentifiersForAppListDetailCells() -> [String] {
        var reuseIdentifiers: [String] = []
        //index starts at 1 because index 0's cell is of class AppListDetailTitleTableViewCell
        for index in 1..<getCellCount() {
            reuseIdentifiers.append(getReuseIdentifier(at: index))
        }
        return reuseIdentifiers
    }
    
    func getTextForCell(at index: Int) -> String {
        return getTextForCell(type: CellType.allCases[index])
    }
    
    private func getTextForCell(type: CellType) -> String {
        switch type {
        case .title:
            return ""
        case .summary:
            return app.summary
        case .releaseDate:
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YYYY"
            let releaseDateString = "Released: " + formatter.string(from: app.releaseDate)
            return releaseDateString
        case .category:
            return "Category: " + app.category
        case .publisher:
            return "Published by " + app.publisher
        }
    }
}
