//
//  YearInfoCell.swift
//  SPHAssignment
//
//  Created by Optimum  on 11/8/20.
//  Copyright © 2020 Jai. All rights reserved.
//

import UIKit

class YearInfoCell: UITableViewCell {
       @IBOutlet weak var titleLbl: UILabel!
       @IBOutlet weak var lblQ1: UILabel!
       @IBOutlet weak var lblQ2: UILabel!
       @IBOutlet weak var lblQ3: UILabel!
       @IBOutlet weak var lblQ4: UILabel!
       @IBOutlet weak var lblYear: UILabel!
       @IBOutlet weak var bgView: UIView!
       @IBOutlet weak var dropImgVw: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bgView.dropShadow()
        self.bgView.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
