//
//  Model.swift
//  SoftMachineTest
//
//  Created by Филяев Илья on 28.10.2021.
//

import Foundation

// MARK: - Main Model

struct Breeds: Decodable {
    let message: [String: [String]]
    let status: String
}

// MARK: - Detail Model

struct Photos: Decodable {
    let message: [String]
    let status: String
}

