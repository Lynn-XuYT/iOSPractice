//
//  LDFifthSwiftViewController.swift
//  LittleDemo
//
//  Created by lynn on 2019/1/30.
//  Copyright © 2019 Lynn. All rights reserved.
//

import Foundation
import UIKit

class LDFifthSwiftViewController: UIViewController {
    let cellID = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "SwiftViewController"
        
        let tableView = UITableView.init(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension LDFifthSwiftViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
}
