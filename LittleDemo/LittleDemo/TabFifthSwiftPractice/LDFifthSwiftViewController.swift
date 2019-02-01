//
//  LDFifthSwiftViewController.swift
//  LittleDemo
//
//  Created by lynn on 2019/1/30.
//  Copyright © 2019 Lynn. All rights reserved.
//

import Foundation
import UIKit

class LDFifthSwiftViewController: UITabBarController {
    let cellID = "cell"
    var dataSource = [String]()
    let testClass = LDFirstSwiftClass.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "SwiftViewController"
        
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        dataSource = self.getDataSource() as! [String]
        tableView.reloadData()
    }
    func getDataSource() -> Array<Any> {
        var dataSource = [String]()
        dataSource.append("a")
        dataSource.append("b")
        dataSource.append("c")
        dataSource.append("d")
        return dataSource;
    }
}

extension LDFifthSwiftViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init();
        }
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell ?? UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        let vc = UIViewController.init()
        vc.view.backgroundColor = UIColor.white
        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
        
        testClass.test()
    }
}
