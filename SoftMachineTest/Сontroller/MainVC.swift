//
//  MainVC.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 31.10.2021.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let networkService = NetworkService()
    public var indicator = UIActivityIndicatorView()
    static var state = false

    private func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.view.center
        tableView.addSubview(indicator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        activityIndicator()
        indicator.startAnimating()
        networkService.getData(url: "https://dog.ceo/api/breeds/list/all", tableView: tableView, collectionView: nil) { (breeds:Breeds) in
            NetworkService.array.append(contentsOf: breeds.message.keys)
            NetworkService.array.sort()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        MainVC.state = true
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}

