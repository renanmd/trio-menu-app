//
//  ViewController.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var viewLogoShadow: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var menuData: Menus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
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
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = menuData?.menus[section].name
        label.font = UIFont(name: "Inter-Bold", size: 36)
        return label
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData?.menus.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let menuData = menuData else {
            return 0
        }
        return menuData.menus[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.textLabel?.text = menuData?.menus[indexPath.section].items[indexPath.row].name
        if let items = menuData?.menus[indexPath.section].items {
            cell.configure(items: items)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
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

