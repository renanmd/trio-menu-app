//
//  McDonaldsService.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 01/04/22.
//

import Foundation
import Alamofire

public class McDonaldsService {
    public static let shared = McDonaldsService()
    
    private let domain = "https://mcdonalds.trio.dev"
    
    public func fetchMenus(completion: @escaping (_ menus: [Menu]?)->()) {
        let request = AF.request("\(domain)/menu")
        
        request.responseDecodable(of: MenuResponse.self) { (response) in
            guard let menuResponse = response.value else {
                completion(nil)
                return
            }
            
            completion(menuResponse.menus)
        }
    }
}
