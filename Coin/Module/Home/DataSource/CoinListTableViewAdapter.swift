//
//  CoinListTableViewAdapter.swift
//  Coin
//
//  Created by riddhi  on 01/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import Foundation
import UIKit

protocol CoinListTableViewAdapterDelegate: AnyObject {
    func selectCoin(Coin : Coin)
    func filterPrice(max : Bool)
    func filter24H(max : Bool)
    func filterMarketCap(max : Bool)
}

final class CoinListTableViewAdapter : NSObject{
    weak var delegate: CoinListTableViewAdapterDelegate?
    
    private let CoinListTableView: UITableView
    var filter = "price"
    var isPriceMaxShow = true
    var isHourMaxShow = false
    var isMarketCapMaxShow = false
    var Items : [Coin] = []{
        didSet {
            setup()
        }
    }
    
    init(with productListTableView: UITableView) {
         self.CoinListTableView = productListTableView
         self.CoinListTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
         
         self.CoinListTableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
         super.init()
         self.CoinListTableView.rowHeight = UITableView.automaticDimension
         self.CoinListTableView.estimatedRowHeight = 80
         
         self.CoinListTableView.dataSource = self
         self.CoinListTableView.delegate = self
     }
     
    
     private func setup() {
         CoinListTableView.reloadData()
       
     }
}

extension CoinListTableViewAdapter : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        headerCell.priceImgUp.isHidden = true
        headerCell.priceImgDown.isHidden = true
        headerCell.hourImgUp.isHidden = true
        headerCell.hourImgDown.isHidden = true
        headerCell.marketCapImgUp.isHidden = true
        headerCell.marketCapImgDown.isHidden = true
        
        if(filter == "price"){
            if(self.isPriceMaxShow){
                headerCell.priceImgUp.isHidden = false
                headerCell.priceImgDown.isHidden = true
            }else{
                headerCell.priceImgUp.isHidden = true
                headerCell.priceImgDown.isHidden = false
            }
            
        }
        
        if(filter == "hour"){
            if(self.isHourMaxShow){
                headerCell.hourImgUp.isHidden = false
                headerCell.hourImgDown.isHidden = true
            }else{
                headerCell.hourImgUp.isHidden = true
                headerCell.hourImgDown.isHidden = false
            }
        }
        
        if(filter == "marketcap"){
            if(self.isMarketCapMaxShow){
                headerCell.marketCapImgUp.isHidden = false
                headerCell.marketCapImgDown.isHidden = true
            }else{
                headerCell.marketCapImgUp.isHidden = true
                headerCell.marketCapImgDown.isHidden = false
            }
            
        }
        
        headerCell.priceButtonPressed = {
            self.isPriceMaxShow = !self.isPriceMaxShow
            self.filter = "price"
            self.CoinListTableView.reloadData()
            self.delegate?.filterPrice(max: self.isPriceMaxShow)
        }
        headerCell.hourButtonPressed = {
            self.isHourMaxShow = !self.isHourMaxShow
            self.filter = "hour"
            self.delegate?.filter24H(max: self.isHourMaxShow)
            self.CoinListTableView.reloadData()
        }
        
        headerCell.marketCapButtonPressed = {
            self.isMarketCapMaxShow = !self.isMarketCapMaxShow
            self.filter = "marketcap"
            self.delegate?.filterMarketCap(max: self.isMarketCapMaxShow)
            self.CoinListTableView.reloadData()
        }
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        let item = Items[indexPath.row]
        cell.configuCell(coin: item)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Items[indexPath.row]
        self.delegate?.selectCoin(Coin: item)
        
    }
    
}

