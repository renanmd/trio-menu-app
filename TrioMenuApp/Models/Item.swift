//
//  Item.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import Foundation

struct Item: Decodable {
    let name: String
    let description: String
    let price: Double
    let url: String
}
