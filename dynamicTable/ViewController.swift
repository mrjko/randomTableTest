//
//  ViewController.swift
//  dynamicTable
//
//  Created by Jimmy Ko on 2019-09-08.
//  Copyright © 2019 Jimmy Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomTableView: UITableView!
    @IBOutlet weak var topRightTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomTableView.delegate = self
        self.bottomTableView.dataSource = self
        
        setUpTableView(self.bottomTableView)
        
        self.topRightTableView.delegate = self
        self.topRightTableView.dataSource = self
        
        setUpTableView(self.topRightTableView)

        
        self.topRightTableView.register(DynamicTableViewCell.self, forCellReuseIdentifier: "dynamicTableViewCell")
        self.bottomTableView.register(DynamicTableViewCell.self, forCellReuseIdentifier: "dynamicTableViewCell")
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)

    }

    @objc func runTimedCode() {
        guard let lastVisibleIndexPath = self.bottomTableView.indexPathsForVisibleRows?.last else {
            return
        }
        
        if lastVisibleIndexPath.row == 14 {
            print("scrolling to top")
            self.bottomTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            return
        }
        
        self.bottomTableView.scrollToRow(at: lastVisibleIndexPath, at: .top, animated: true)
    }

    private func setUpTableView(_ tableView: UITableView) {
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        tableView.separatorInset = .zero
        tableView.isUserInteractionEnabled = false
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.bottomTableView.dequeueReusableCell(withIdentifier: "dynamicTableViewCell") as? DynamicTableViewCell else {
            print("error dequeuing dynamic table view cell")
            return UITableViewCell()
        }
        
        cell.setUpCustomCell(columns: ["long", "short", "medium"], ratios: [0.5, 0.2, 0.3])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
