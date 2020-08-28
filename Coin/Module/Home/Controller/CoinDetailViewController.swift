//
//  CoinDetailViewController.swift
//  Coin
//
//  Created by riddhi  on 02/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import UIKit
import Nuke

class CoinDetailViewController: UIViewController {
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var coinPriceLabel: UILabel!
    @IBOutlet private weak var marketCapRankLabel: UILabel!
    @IBOutlet private weak var marketCapLabel: UILabel!
    @IBOutlet private weak var totalVolumeLabel: UILabel!
    @IBOutlet private weak var coin24HHighLabel: UILabel!
    @IBOutlet private weak var coin24HLowLabel: UILabel!
    @IBOutlet private weak var totalSupplyLabel: UILabel!
    @IBOutlet private weak var circulatingSupplyLabel: UILabel!
    @IBOutlet private weak var suggestionLabel: UILabel!
    @IBOutlet private weak var suggestionStackView: UIStackView!

    var coin : Coin!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarFor(controller: self, title: "\(self.coin.coinName)", isTransperent: false, hideShadowImage: false) {
            self.navigationController?.popViewController(animated: true)
        }
        
        
        self.view.backgroundColor = .background

        let options = ImageLoadingOptions(
            transition: .fadeIn(duration: 0.33)
        )
        
        if let url = URL(string: coin.coinImage){
            Nuke.loadImage(with: url, options: options, into: self.coinImageView)
        }
        
        self.coinNameLabel.text = "\(self.coin.coinName) (\(self.coin.name.uppercased()))"
        self.coinPriceLabel.text = "$ \(self.coin.price)"
        self.marketCapRankLabel.text = "\(self.coin.marketCapRank)"
        let marketCap = Int(self.coin.marketCap).withCommas()
        self.marketCapLabel.text = "$ \(marketCap)"
        self.totalVolumeLabel.text = "$ \(Int(self.coin.totalVolume).withCommas())"
        self.coin24HHighLabel.text = "$ \(Int(self.coin.coin24H).withCommas())"
        self.coin24HLowLabel.text = "$ \(Int(self.coin.coin24HLow).withCommas())"
        self.totalSupplyLabel.text = "$ \(Int(self.coin.totalSupply).withCommas())"
        self.circulatingSupplyLabel.text = "$ \(Int(self.coin.circulatingSupply).withCommas())"
        if(self.coin.suggestion != ""){
            self.suggestionLabel.text = self.coin.suggestion
            self.suggestionStackView.isHidden = false
        }
    }

}
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
