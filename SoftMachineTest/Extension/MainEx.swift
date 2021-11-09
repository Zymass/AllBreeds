//
//  MainEx.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 02.11.2021.
//

import UIKit

// MARK: - TableViewDataSource

extension MainVC: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkService.array.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = NetworkService.array[indexPath.row]
        return cell
    }
}


// MARK: - TableViewDelegate

extension MainVC: UITableViewDelegate {
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        DetailVC.breed = NetworkService.array[indexPath.row]
        DetailVC.state.toggle()
        navigationController?.pushViewController(vc, animated: true)
    }
}

