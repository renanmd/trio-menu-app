//
//  MenuItemCollectionViewCell.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 30/03/22.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var viewWithBorder: UIView!
    
    static let identifier = "MenuItemCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MenuItemCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewWithBorder()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.lblItemName.text = nil
        self.imgItem.image = nil
    }
    
    public func configure(item: Item) {
        self.lblItemName.text = item.name
        self.imgItem.image = UIImage(named: item.url)
    }
    
    func configureViewWithBorder() {
        self.viewWithBorder.layer.borderWidth = 1.0
        self.viewWithBorder.layer.borderColor = UIColor(red: 216 / 255, green: 216 / 255, blue: 216 / 255, alpha: 1.0).cgColor
        self.viewWithBorder.layer.cornerRadius = 5.0
        self.viewWithBorder.layer.masksToBounds = true
    }
}
