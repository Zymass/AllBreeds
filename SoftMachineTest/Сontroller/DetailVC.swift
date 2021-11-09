//
//  DetailVC.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 31.10.2021.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var breedTitle: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        goBack()
    }
    
    let networkService = NetworkService()
    static var breed = String()
    static var indicator = UIActivityIndicatorView()
    static var state = false

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.photos.removeAll()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionVCell.identifier)
        configureRefreshControl()
        activityIndicator()
        DetailVC.indicator.startAnimating()
        breedTitle.text = DetailVC.breed
        networkService.getData(url: "https://dog.ceo/api/breed/\(DetailVC.breed)/images", tableView: nil, collectionView: collectionView) { (photos: Photos) in
            NetworkService.urlPhoto.append(contentsOf: photos.message)
            self.networkService.convertFromURL(collectionView: self.collectionView)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            NetworkService.photos.removeAll()
            DetailVC.state.toggle()
        }
    }
}


