//
//  ContentListTableViewCell.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

class ContentListTableViewCell: UITableViewCell {

    @IBOutlet weak var labelHeading : UILabel!
    @IBOutlet weak var labelHeading2 : UILabel!
    @IBOutlet weak var imageViewFace: CustomImageView!
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.setupImages()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    func configure(_ item: BeaconRecord!) {
        self.labelHeading.text = item.title
        self.labelHeading2.text = item.subTitle
        
        if item.imageUrl != "" {
            self.imageViewFace.buildImage(item.imageUrl)
            self.imageViewFace.alpha = 1.0
            self.constraintWidth.constant = 100.0
        } else {
            self.imageViewFace.image = nil
            self.imageViewFace.alpha = 0.0
            self.constraintWidth.constant = 0.0
        }
        
        self.accessoryType = (item.contactWebsite == "") ? .none : .disclosureIndicator
        self.selectionStyle = .gray
    }
    
    func setupImages() {
        self.imageViewFace.clipsToBounds = true
        self.imageViewFace.layer.borderWidth = 1.0
        self.imageViewFace.layer.borderColor = UIColor.gray.cgColor
        self.imageViewFace.backgroundColor = UIColor.white
    }

}
