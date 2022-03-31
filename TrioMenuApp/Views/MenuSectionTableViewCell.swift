//
//  MenuSectionTableViewCell.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 30/03/22.
//

import UIKit
import Kingfisher

protocol MenuSectionTableViewCellDelegate: AnyObject {
    func didTapItem(item: Item)
}

class MenuSectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items = [Item]()
    private weak var delegate: MenuSectionTableViewCellDelegate?

    static let identifier = "MenuSectionTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MenuSectionTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(MenuItemCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuItemCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.items = []
        self.collectionView.reloadData()
    }
    
    func configure(items: [Item], delegate: MenuSectionTableViewCellDelegate) {
        self.items = items
        collectionView.reloadData()
        self.delegate = delegate
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCollectionViewCell.identifier, for: indexPath)as! MenuItemCollectionViewCell
        
        cell.configure(item: items[indexPath.row], imageURL: items[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Cell \(indexPath.row) selected")
        
        self.delegate?.didTapItem(item: items[indexPath.row])
    }
}
