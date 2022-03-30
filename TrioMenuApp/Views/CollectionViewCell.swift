//
//  CollectionViewCell.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 30/03/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var viewWithBorder: UIView!
    
    static let identifier = "CollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewWithBorder()
    }
    
    public func configure(item: Item) {
        self.lblItemName.text = item.name
        self.imgItem.image = UIImage(named: item.url)
    }
    
    func configureViewWithBorder() {
        self.viewWithBorder.layer.borderWidth = 1
        self.viewWithBorder.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        self.viewWithBorder.layer.cornerRadius = 5
        self.viewWithBorder.layer.masksToBounds = true
    }
}
