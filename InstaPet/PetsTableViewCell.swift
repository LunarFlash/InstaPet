//
//  PetsTableViewCell.swift
//  InstaPet
//
//  Created by Terry Wang on 7/21/15.
//  Copyright (c) 2015 Vento LLC. All rights reserved.
//

import UIKit

class PetsTableViewCell: PFTableViewCell {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var petImageView:UIImageView?
    @IBOutlet weak var petNameLabel:UILabel?
    @IBOutlet weak var petVotesLabel:UILabel?
    @IBOutlet weak var petCreditLabel:UILabel?
    
    

}
