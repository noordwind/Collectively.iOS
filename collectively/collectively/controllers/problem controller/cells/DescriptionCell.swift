//
//  DescriptionCell.swift
//  collectively
//
//  Created by Łukasz Bożek on 25/11/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    @IBOutlet weak var desc: UITextView!
    
    func setupWith(problem: MapModel) {
        desc.text = problem.description
    }
}
