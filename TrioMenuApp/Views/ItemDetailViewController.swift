//
//  ItemDetailViewController.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 31/03/22.
//

import UIKit

class ItemDetailViewController: UIViewController {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var viewPriceWithBorder: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblItemDescription: UILabel!
    
    public var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.loadItem()
    }

    func setupUI() {
        self.viewPriceWithBorder.layer.borderWidth = 1.0
        self.viewPriceWithBorder.layer.borderColor = UIColor.black.cgColor
        self.viewPriceWithBorder.layer.cornerRadius = 15.0
    }
    
    func loadItem() {
        if let urlString = item?.url, let url = URL(string: urlString) {
            self.imgItem.kf.setImage(with: url)
        }
        
        self.lblItemName.text = item?.name
        self.lblPrice.text = ("$\(item?.price ?? 0)")
        self.lblItemDescription.text = item?.description
    }
}
