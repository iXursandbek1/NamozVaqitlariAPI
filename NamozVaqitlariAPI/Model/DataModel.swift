//
//  DataModel.swift
//  NamozVaqitlariAPI
//
//  Created by Mac on 05/01/23.
//

import Foundation

struct DataModel: Codable {
    
    let status: Bool
    let date: String
    let weekdate: String
    let result: Result
}

struct Result: Codable {
    
    let tong_saharlik: String
    let quyosh: String
    let peshin: String
    let asr: String
    let shom_iftor: String
    let xufton: String
}
