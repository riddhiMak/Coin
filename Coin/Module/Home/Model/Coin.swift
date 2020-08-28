//
//  Coin.swift
//  Coin
//
//  Created by riddhi  on 01/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import Foundation

struct Coin: Codable {
    var id: String
    var coinImage: String
    var name: String
    var coinName: String
    var coin24H : Double
    var price : Double
    var marketCap : Double
    var marketCapRank : Int
    var totalVolume : Double
    var totalSupply : Double
    var coin24HLow : Double
    var circulatingSupply : Double
    var suggestion : String
}

struct CoinID : Codable {
    var id: String
    var suggestion : String?
}

