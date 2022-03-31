//
//  ViewController.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import UIKit
import Alamofire

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var viewLogoShadow: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var menuData: Menus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(MenuSectionTableViewCell.nib(), forCellReuseIdentifier: MenuSectionTableViewCell.identifier)
        tableview.delegate = self
        tableview.dataSource = self
        
        fetchMenu { menu in
            guard let menu = menu else {
                return
            }
            self.menuData = menu
            self.tableview.reloadData()
        }
        
        self.viewLogoShadow.dropShadow()
    }
    
    func fetchMenu(completion: @escaping (_ menu: Menus?)->()) {
        let request = AF.request("https://mcdonalds.trio.dev/menu")
        
        request.responseDecodable(of: Menus.self) { (response) in
            guard let menus = response.value else {
                completion(nil)
                return
            }
            completion(menus)
            self.menuData = menus
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = menuData?.menus[section].name
        label.font = UIFont(name: "Inter-Bold", size: 36)
        
        label.backgroundColor = .white
        
        return label
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData?.menus.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: MenuSectionTableViewCell.identifier, for: indexPath) as! MenuSectionTableViewCell

        if let items = menuData?.menus[indexPath.section].items {
            cell.configure(items: items, delegate: self)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
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

extension MenuViewController: MenuSectionTableViewCellDelegate {
    func didTapItem(item: Item) {
//        let vc = UIViewController(nibName: "ItemDetailViewController", bundle: nil)
        let vc = ItemDetailViewController()
            vc.setUpItems(item: item)

            self.present(vc, animated: true)
    }
}

