//
//  HomeTableViewCell.swift
//  Coin
//
//  Created by riddhi  on 01/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import UIKit
import Nuke
class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var coinIDLabel: UILabel!
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var coin24HLabel: UILabel!
    @IBOutlet private weak var marketCapLabel: UILabel!
    @IBOutlet private weak var seperatorLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .background
    }
    func configuHeader(){
        coinIDLabel.text = "#"
        coinIDLabel.textColor = .primary
        
        coinImageView.isHidden = true
        nameLabel.text = "COIN"
        nameLabel.textColor = .primary
        
        priceLabel.text = "PRICE"
        priceLabel.textColor = .primary
        
        coin24HLabel.text = "24H"
        coin24HLabel.textColor = .primary
        
        marketCapLabel.text = "MARKET CAP"
        marketCapLabel.textColor = .primary
        seperatorLineView.isHidden = true
    }
    func configuCell(coin : Coin){
        coinIDLabel.text = coin.id
        coinIDLabel.textColor = .gray
        let options = ImageLoadingOptions(
            transition: .fadeIn(duration: 0.33)
        )
        
        if let url = URL(string: coin.coinImage){
            Nuke.loadImage(with: url, options: options, into: self.coinImageView)
        }
        nameLabel.text = coin.name.uppercased()
        nameLabel.textColor = .gray
        
        priceLabel.text = String(format: "%.2f", coin.price)
        priceLabel.textColor = .gray
        
        coin24HLabel.text = String(format: "%.2f", coin.coin24H)
        coin24HLabel.textColor = .gray
        
        marketCapLabel.text = String(format: "%.0f", coin.marketCap)
        marketCapLabel.textColor = .gray

        seperatorLineView.isHidden = false
         
    }
}
