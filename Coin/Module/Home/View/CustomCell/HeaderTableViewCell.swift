//
//  HeaderTableViewCell.swift
//  Coin
//
//  Created by riddhi  on 01/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    var priceButtonPressed: (() -> ()) = {}
    var hourButtonPressed: (() -> ()) = {}
    var marketCapButtonPressed: (() -> ()) = {}
    @IBOutlet var priceImgUp : UIImageView!
    @IBOutlet var priceImgDown : UIImageView!
    
    @IBOutlet var hourImgUp : UIImageView!
    @IBOutlet var hourImgDown : UIImageView!
    
    @IBOutlet var marketCapImgUp : UIImageView!
    @IBOutlet var marketCapImgDown : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction
       private func priceButtonAction(_ sender: UIButton) {
           priceButtonPressed()
       }
    
    @IBAction
          private func hourButtonAction(_ sender: UIButton) {
              hourButtonPressed()
          }
       
    @IBAction
          private func marketCapButtonAction(_ sender: UIButton) {
              marketCapButtonPressed()
          }
       
}
