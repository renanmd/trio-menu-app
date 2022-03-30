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
        return label
    }
    //This adds sections. Here it is adding a section for each name (6 total) + the 6 items in the array. 24total
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
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuData?.menus[indexPath.section].items[indexPath.row].name
        
        return cell
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

