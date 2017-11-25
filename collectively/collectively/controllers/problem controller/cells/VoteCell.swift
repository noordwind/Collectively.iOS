//
//  VoteCell.swift
//  collectively
//
//  Created by Łukasz Bożek on 25/11/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit

class VoteCell: UITableViewCell {
    @IBOutlet weak var votesCountLabel: UILabel!
    @IBOutlet weak var voteDownImg: UIImageView!
    @IBOutlet weak var voteUpImg: UIImageView!
    var votes = 0
    
    func setupWith(problem: MapModel) {
        votes = problem.positiveVotesCount + problem.negativeVotesCount
        
        updateVotes(v: votes)
    }
    
    @IBAction func voteUp(_ sender: Any) {
        if voteDownImg.image == #imageLiteral(resourceName: "thumb-down") {
            votes += 1
            voteDownImg.image = #imageLiteral(resourceName: "thumb-downin")
        }
        if voteUpImg.image == #imageLiteral(resourceName: "thumb-up") {
            votes -= 1
            voteUpImg.image = #imageLiteral(resourceName: "thumb-upin")
        } else {
            votes += 1
            voteUpImg.image = #imageLiteral(resourceName: "thumb-up")
        }
        
        updateVotes(v: votes)
    }
    
    @IBAction func voteDown(_ sender: Any) {
        if voteUpImg.image == #imageLiteral(resourceName: "thumb-up") {
            votes -= 1
            voteUpImg.image = #imageLiteral(resourceName: "thumb-upin")
        }
        if voteDownImg.image == #imageLiteral(resourceName: "thumb-down") {
            votes += 1
            voteDownImg.image = #imageLiteral(resourceName: "thumb-downin")
        } else {
            votes -= 1
            voteDownImg.image = #imageLiteral(resourceName: "thumb-down")
        }
        
        updateVotes(v: votes)
    }
    
    func updateVotes(v: Int) {
        if v >= 0 {
            votesCountLabel.textColor = .green
            votesCountLabel.text = "+\(v)"
        } else {
            votesCountLabel.textColor = .red
            votesCountLabel.text = "\(v)"
        }
        
    }
}
