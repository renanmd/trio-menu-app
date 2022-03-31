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
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return }

        setUpViewPriceWithBorder()
        let url = URL(string: item.url)
        self.imgItem.kf.setImage(with: url)
        self.lblItemName.text = item.name
        self.lblPrice.text = ("$\(item.price)")
        self.lblItemDescription.text = item.description
    }
    
    func setUpViewPriceWithBorder() {
        self.viewPriceWithBorder.layer.borderWidth = 1
        self.viewPriceWithBorder.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1).cgColor
        self.viewPriceWithBorder.layer.cornerRadius = 15
    }
    
    func setUpItems(item: Item) {
        self.item = item
    }
}
