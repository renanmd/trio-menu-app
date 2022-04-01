//
//  Item.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import Foundation

public struct Item: Decodable {
    public let name: String
    public let description: String
    public let price: Double
    public let url: String
}
