//
//  AppListDetailViewController.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-26.
//  Copyright © 2018 nil. All rights reserved.
//

import UIKit

class AppListDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    private let imageStore = ImageStore()
    private var cellBuilder: AppListDetailCellBuilder!
    var app: App!
    lazy var allCellTypes = {
        return cellBuilder.getAllCases()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cellBuilder = AppListDetailCellBuilder(app: app)
        setupTableView()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        for reuseIdentifier in cellBuilder.getReuseIdentifiersForAppListDetailCells() {
            self.tableView.register(AppListDetailTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        }
    }

    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellBuilder.getCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = cellBuilder.getReuseIdentifier(at: indexPath.row)
        if indexPath.row == allCellTypes.index(of: .title) {
            return getAppListTitleCell(for: tableView, withIdentifier: reuseIdentifier, at: indexPath)
        }
        return getAppListCell(for: tableView, withIdentifier: reuseIdentifier, at: indexPath)
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == allCellTypes.index(of: .title) {
            openDefaultBrowser(to: app.storeUrl)
        } else if indexPath.row == allCellTypes.index(of: .publisher) {
            openDefaultBrowser(to: app.publisherUrl)
        }
    }
    
    // MARK: - Helper Functions
    private func getAppListTitleCell(for tableView: UITableView, withIdentifier identifier: String, at indexPath: IndexPath) -> AppListDetailTitleTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AppListDetailTitleTableViewCell
        cell.iconImageView.image = imageStore.image(forKey: app.bundleId)
        cell.titleLabel.text = app.title
        cell.priceLabel.text = app.price + " " + app.currency
        return cell
    }
    
    private func getAppListCell(for tableView: UITableView, withIdentifier identifier: String, at indexPath: IndexPath) -> AppListDetailTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AppListDetailTableViewCell
        cell.infoLabel.text = cellBuilder.getTextForCell(at: indexPath.row)
        setDisclosureIndicator(for: cell, withIdentifier: identifier)
        return cell
    }
    
    private func setDisclosureIndicator(for cell: AppListDetailTableViewCell, withIdentifier identifier: String) {
        guard let publisherIndex = allCellTypes.index(of: .publisher) else { return }
        if identifier == cellBuilder.getReuseIdentifier(at: publisherIndex) {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
            cell.selectionStyle = .none
        }
    }
    
    private func openDefaultBrowser(to url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
