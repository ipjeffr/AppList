//
//  AppListViewController.swift
//  App List
//
//  Created by Jeffrey Ip on 2018-09-26.
//  Copyright © 2018 nil. All rights reserved.
//

import UIKit

class AppListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    private var apps: [App] = []
    private let client = APIClient()
    private let cellId = "AppListTableViewCell"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        fetchApps()
    }

    // MARK: - Setup
    private func setupTableView() {
        hideTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "TOP PAID APPS"
    }
    
    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AppListTableViewCell
        cell.nameLabel.text = apps[indexPath.row].title
        return cell
    }

    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let appListCell = cell as? AppListTableViewCell {
            fetchImage(for: appListCell, using: apps[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentAppListDetailViewController(for: apps[indexPath.row])
    }
    
    // MARK: - TableView Helper Functions
    private func hideTableView() {
        spinner.startAnimating()
        tableView.isHidden = true
    }
    
    private func showTableView() {
        DispatchQueue.main.async {
            [weak self] in
            self?.spinner.stopAnimating()
            UIView.animate(withDuration: 0.5, animations: {
                self?.tableView.isHidden = false
            })
        }
    }
    
    // MARK: - Networking Completion Actions
    private func fetchApps() {
        client.fetchPaidAppList {
            [weak self] appListResult in
            
            switch appListResult {
            case .success(let apps):
                self?.apps = apps
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self?.showTableView()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func fetchImage(for cell: AppListTableViewCell, using app: App) {
        client.fetchImage(for: app) {
            imageResult in
            
            switch imageResult {
            case .success(let image):
                cell.update(with: image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation
    private func presentAppListDetailViewController(for app: App) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appListDetailVC = storyboard.instantiateViewController(withIdentifier: "AppListDetailViewController") as! AppListDetailViewController
        appListDetailVC.app = app
        navigationController?.pushViewController(appListDetailVC, animated: true)
    }
}
