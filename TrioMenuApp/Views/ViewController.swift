//
//  ViewController.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var viewLogoShadow: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMenu()
        self.viewLogoShadow.dropShadow()
    }

    func fetchMenu() {
        let request = AF.request("https://mcdonalds.trio.dev/menu")
        
        request.responseDecodable(of: Menus.self) { (response) in
            guard let menus = response.value else { return }
            print(menus.menus)
        }
    }

}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
                layer.shadowRadius = 2
                layer.shouldRasterize = true
                layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

