//
//  NetworkService.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 02.11.2021.
//

import UIKit

class NetworkService {
    

    static var array = [String]()
    static var imageCache = NSCache<NSString, UIImage>()
    static var countOfUploadedPhotos = Int()
    static var urlPhoto = [String]()
    static var photos = [UIImage]()

    // MARK: - Get Data
    
    func getData <T:Decodable>(url: String, tableView: UITableView? , collectionView: UICollectionView?,completion: @escaping (T) -> ()) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { data, resp, error in
            guard let data = data else {
                return
            }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let error {
                print("Failed to decode", error)
            }
        }.resume()
    }
    
    // MARK: - Data fetcher
    
    func convertFromURL(collectionView: UICollectionView?) {
        var image = UIImage()
        DispatchQueue.global().async {
            for i in NetworkService.urlPhoto{
                if let cachedImage = NetworkService.imageCache.object(forKey: i as NSString) {
                    NetworkService.photos.append(cachedImage)
            } else if DetailVC.state {
                guard let url = URL(string: i) else { return }
            let data: Data = try! Data(contentsOf: url)
                        image = UIImage(data: data) ?? UIImage()
                DispatchQueue.main.async {
                    guard let collectionView = collectionView else {
                        return
                    }
                    collectionView.reloadData()
                }
                NetworkService.photos.append(image)
                NetworkService.imageCache.setObject(image, forKey: i as NSString)
                }
                if NetworkService.urlPhoto.count > 10{
                    if NetworkService.countOfUploadedPhotos > 10 {
                        DispatchQueue.main.async {
                            DetailVC.indicator.stopAnimating()
                            DetailVC.indicator.hidesWhenStopped = true
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        DetailVC.indicator.stopAnimating()
                        DetailVC.indicator.hidesWhenStopped = true
                    }
                }
            DispatchQueue.main.async {
                NetworkService.countOfUploadedPhotos += 1
                guard let collectionView = collectionView else {
                    return
                }
                collectionView.reloadData()
            }
                }
            NetworkService.countOfUploadedPhotos = 0
            NetworkService.urlPhoto.removeAll()
        }
    }
}
