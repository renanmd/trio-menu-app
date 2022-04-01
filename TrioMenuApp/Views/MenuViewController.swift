//
//  ViewController.swift
//  TrioMenuApp
//
//  Created by Renan Diniz on 29/03/22.
//

import UIKit
import Alamofire
import Spinners

class MenuViewController: UIViewController {
    @IBOutlet weak var viewLogoShadow: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    private var menus: [Menu] = []
    private var spinners: Spinners?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupUI()
        self.loadData()
    }

    private func setupUI() {
        self.spinners = Spinners(type: .cube, with: self)
        self.viewLogoShadow.dropShadow()
    }
    
    private func loadData() {
        self.spinners?.present()
        
        McDonaldsService.shared.fetchMenus { [weak self] menus in
            DispatchQueue.main.async {
                self?.spinners?.dismiss()
                guard let menus = menus else {
                    return
                }
                
                self?.menus = menus
                
                self?.tableview.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        self.tableview.register(MenuSectionTableViewCell.nib(), forCellReuseIdentifier: MenuSectionTableViewCell.identifier)
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.sectionHeaderHeight = UITableView.automaticDimension
        self.tableview.estimatedSectionHeaderHeight = 66.0
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.contentView.backgroundColor = .white

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = self.menus[section].name
        label.font = UIFont(name: "Inter-Bold", size: 36.0)
        
        headerView.contentView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: headerView.contentView.leadingAnchor, constant: 12.0).isActive = true
        label.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor, constant: -12.0).isActive = true
        label.topAnchor.constraint(equalTo: headerView.contentView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor).isActive = true
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.menus.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: MenuSectionTableViewCell.identifier, for: indexPath) as! MenuSectionTableViewCell

        let items = self.menus[indexPath.section].items
        cell.configure(items: items, delegate: self)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}

extension MenuViewController: MenuSectionTableViewCellDelegate {
    func didTapItem(item: Item) {
        let itemDetailViewController = ItemDetailViewController()
        itemDetailViewController.item = item
        
        self.present(itemDetailViewController, animated: true)
    }
}

