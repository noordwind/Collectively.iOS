//
//  GroupCell.swift
//  collectively
//
//  Created by Łukasz Bożek on 25/11/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit
import Kingfisher

class GroupCell: UITableViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var reportedByLabel: UILabel!
    
    func setupWith(problem: MapModel) {
        reportedByLabel.text = "Zgłoszone przez: " + problem.author.name
        
        if let url = URL(string: problem.photo?.medium ?? "") {
            backgroundImage.kf.setImage(with: url)
        }
    }
}
