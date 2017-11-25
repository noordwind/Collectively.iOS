//
//  LocationCell.swift
//  collectively
//
//  Created by Łukasz Bożek on 25/11/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    
    func setupWith(problem: MapModel) {
        locationLabel.text = problem.location.address
    }
}
