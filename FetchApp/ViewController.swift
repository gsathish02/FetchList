//
//  ViewController.swift
//  FetchApp
//
//  Created by Sathish Kumar G on 10/9/20.
//  Copyright © 2020 Sathish Kumar G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    let CellIdentifier = Constants.CellIdentifier
    var feedManager = FeedManager()
    var totalResult: [Objects] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader()
        setupTableView()
        fetchResult()
    }
    
    private func setupTableView() {
        listTableView.register(ListTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(ListTableViewCell.self))
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.rowHeight = UITableView.automaticDimension
    }

    private func fetchResult() {
        feedManager.getResult(urlString: Constants.baseUrl, completionHandler:{ receivedModel in
            guard let modelData = receivedModel else {
                //Error Handling
                let alert = UIAlertController(title: "Alert", message: Constants.genericErrorMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            //Setting the model to local variable
            self.totalResult = modelData
            self.listTableView.reloadData()
            self.hideLoader()
        })
    }
    
    private func showLoader() {
        self.listTableView.isHidden = true
        feedManager.showHUD(thisView: self.view)
    }
    
    private func hideLoader() {
        self.listTableView.isHidden = false
        feedManager.hideHUD()
    }
}

// MARK: - Extension
extension ViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totalResult[section].sectionObjects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.totalResult.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(self.totalResult[section].sectionName)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ListTableViewCell.self), for: indexPath) as? ListTableViewCell{
            //Setting the data to the custom cell
            let cellData = totalResult[indexPath.section].sectionObjects[indexPath.row]
            cell.SetupCell(item: cellData)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
