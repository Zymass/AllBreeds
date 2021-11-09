//
//  DetailEx.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 02.11.2021.
//

import UIKit

// MARK: - CollectionViewDataSource


extension DetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NetworkService.photos.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionVCell.identifier, for: indexPath)
       var imageView = UIImageView()
       imageView = UIImageView(image: NetworkService.photos[indexPath.row])
       imageView.frame = cell.bounds
       cell.addSubview(imageView)
       return cell
   }
}

// MARK: - CollectionViewDelegate

extension DetailVC: UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      _ = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionVCell.identifier, for: indexPath)
      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyBoard.instantiateViewController(withIdentifier: "PhotoVC") as! PhotoVC
      PhotoVC.image = NetworkService.photos[indexPath.row]
      setupLongGestureRecognizerOnCollection()
      navigationController?.pushViewController(vc, animated: true)
  }
}

// MARK: - CollectionViewDelegateFlowLayout

extension DetailVC: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   return CGSize(width: 165, height: 165)
   }
}

// MARK: - Buisness

extension DetailVC {
   
   public func configureRefreshControl () {
      collectionView.refreshControl = UIRefreshControl()
      collectionView.refreshControl?.addTarget(self, action:
                                         #selector(handleRefreshControl),
                                         for: .valueChanged)
   }
   
   @objc func handleRefreshControl() {
       DispatchQueue.main.async {
           self.collectionView.reloadData()
           self.collectionView.refreshControl?.endRefreshing()
           NetworkService.photos.shuffle()
       }
   }
   
   public func activityIndicator() {
       DetailVC.indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
       DetailVC.indicator.style = UIActivityIndicatorView.Style.medium
       DetailVC.indicator.center = self.view.center
       collectionView.addSubview(DetailVC.indicator)
   }

   @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
       if (gestureRecognizer.state != .began) {
           return
       }
       let p = gestureRecognizer.location(in: collectionView)
       if let indexPath = collectionView?.indexPathForItem(at: p) {
           savePhoto(image: NetworkService.photos[indexPath.row])
       }
   }

   public func goBack() {
       navigationController?.popToRootViewController(animated: true)
   }
   
   private func savePhoto(image:UIImage) {
       let shareSheetVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
       present(shareSheetVC, animated: true, completion: nil)
   }
}


// MARK: - GestureRecognizerDelegate

extension DetailVC: UIGestureRecognizerDelegate {
   private func setupLongGestureRecognizerOnCollection() {
       let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
       longPressedGesture.minimumPressDuration = 1
       longPressedGesture.delegate = self
       longPressedGesture.delaysTouchesBegan = true
       collectionView?.addGestureRecognizer(longPressedGesture)
   }
}
