//
//  Menu.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import Foundation

public struct Menu: Decodable {
    public let name: String
    public let items: [Item]
}
