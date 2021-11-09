//
//  PhotoVC.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 30.10.2021.
//

import UIKit

class PhotoVC: UIViewController {
    
    static var image = UIImage()
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func pBackButton(_ sender: Any) {
        goBack()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = PhotoVC.image
        pTitle.text = DetailVC.breed
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
