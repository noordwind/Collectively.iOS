//
//  RoundedButton.swift
//  collectively
//
//  Created by Łukasz Bożek on 02/10/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}

