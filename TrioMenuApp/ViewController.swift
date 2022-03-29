//
//  ViewController.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viewLogoShadow: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewLogoShadow.dropShadow()
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

