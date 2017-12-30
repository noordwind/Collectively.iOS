//
//  ProblemViewController.swift
//  collectively
//
//  Created by Łukasz Bożek on 25/11/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit

class ProblemViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var problem: MapModel!
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: String(describing: GroupCell.self), bundle: nil), forCellReuseIdentifier: "group")
        tableView.register(UINib(nibName: String(describing: LocationCell.self), bundle: nil), forCellReuseIdentifier: "location")
        tableView.register(UINib(nibName: String(describing: DescriptionCell.self), bundle: nil), forCellReuseIdentifier: "description")
        tableView.register(UINib(nibName: String(describing: VoteCell.self), bundle: nil), forCellReuseIdentifier: "vote")
        tableView.register(UINib(nibName: String(describing: HistoryAndCommentsCell.self), bundle: nil), forCellReuseIdentifier: "historyAndComments")
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.estimatedSectionHeaderHeight = 60
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        print("\(String(describing: problem.group))")
    }
}

extension ProblemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return getGroupCell(problem: self.problem)
        case 1:
            return getLocCell(problem: self.problem)
        case 2:
            return getDescCell(problem: self.problem)
        case 3:
            return getVoteCell(problem: self.problem)
        case 4:
            return getHistoryAndCommentsCell(problem: self.problem)
        default:
            return getGroupCell(problem: self.problem)
        }
    }
    
    func getGroupCell(problem: MapModel) -> UITableViewCell {
        let cell = tableView.dequeueOrGetNewCellWith(identifier: "group") as! GroupCell
        cell.setupWith(problem: self.problem)
        return cell
    }
    
    func getLocCell(problem: MapModel) -> UITableViewCell {
        let cell = tableView.dequeueOrGetNewCellWith(identifier: "location") as! LocationCell
        cell.setupWith(problem: self.problem)
        return cell
    }
    
    func getDescCell(problem: MapModel) -> UITableViewCell {
        let cell = tableView.dequeueOrGetNewCellWith(identifier: "description") as! DescriptionCell
        cell.setupWith(problem: self.problem)
        return cell
    }
    
    func getVoteCell(problem: MapModel) -> UITableViewCell {
        let cell = tableView.dequeueOrGetNewCellWith(identifier: "vote") as! VoteCell
        cell.setupWith(problem: self.problem)
        return cell
    }
    
    func getHistoryAndCommentsCell(problem: MapModel) -> UITableViewCell {
        let cell = tableView.dequeueOrGetNewCellWith(identifier: "historyAndComments") as! HistoryAndCommentsCell
        cell.setupWith(problem: self.problem)
        return cell
    }
    
}
