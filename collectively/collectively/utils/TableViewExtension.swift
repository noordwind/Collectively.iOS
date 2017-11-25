//
//  TableViewExtension.swift
//  collectively
//
//  Created by Łukasz Bożek on 25/11/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueOrGetNewCellWith(identifier: String) -> UITableViewCell {
        var cell = self.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
}
