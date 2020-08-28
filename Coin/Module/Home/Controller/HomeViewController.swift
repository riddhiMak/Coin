//
//  HomeViewController.swift
//  Coin
//
//  Created by riddhi  on 01/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import UIKit
import Alamofire
class HomeViewController: UIViewController {
    var timer: DispatchSourceTimer?
    var arrCoins = [Coin]()
    @IBOutlet private weak var coinButton: UIButton!
    @IBOutlet private weak var allButton: UIButton!
    @IBOutlet private weak var coinButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var allButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!{
        didSet{
            setUpAdapter()
            bindViewModel(coin : [])
        }
    }
    private var adapterCoinList : CoinListTableViewAdapter?
    private var coinIds : String = ""
    private var isPriceShowMax = true
    private var is24HourwMax = true
    private var isMarketCapShowMax = true
    var arrCoinIds : [CoinID] = []
    var arrIds = [String]()
    var selectedTab = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        setNavigationBarFor(controller: self , title: "CryptovestBot")
        
        var rightNavigationItems: [UIBarButtonItem] = []
        let searchButtonItem = UIBarButtonItemWithClouser(image: UIImage(named: "icon_search"), landscapeImagePhone: nil, style: .plain){
            
            UIView.animate(withDuration: 0.25, animations: {
                self.searchBar.isHidden = false
            }) { (_) in
                self.searchBar.becomeFirstResponder()
            }
            
        }
        searchButtonItem.tintColor = .white
        rightNavigationItems.append(searchButtonItem)
        navigationItem.rightBarButtonItems = rightNavigationItems
        self.configureComponent()
        fetchCoinIds(isShowIndicator: true)
        self.startTimer()
        // Do any additional setup after loading the view.
    }
    
    func configureComponent(){
        self.view.backgroundColor = .background
        searchBar.delegate = self
        searchBar.textField?.backgroundColor = .border
        searchBar.tintColor = .primary
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = .background
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.isHidden = true
        searchBar.layoutIfNeeded()
    }
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    private func setUpAdapter(){
        adapterCoinList = CoinListTableViewAdapter(with: self.tableView)
        adapterCoinList?.delegate = self
    }
    
    private func bindViewModel(coin : [Coin]){
        adapterCoinList?.Items = coin
    }
    
    func startTimer() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer!.schedule(deadline: .now(), repeating: .seconds(50))
        timer!.setEventHandler {
            self.refreshCoinDetails()
        }
        timer!.resume()
    }
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }

    deinit {
        self.stopTimer()
    }
    
    private func refreshCoinDetails(){
        fetchCoinIds(isShowIndicator: false)
    }
    
}
extension HomeViewController {
    @IBAction func allButtonAction(_ sender : UIButton){
        allButtonBottomConstraint.constant = 3
        coinButtonBottomConstraint.constant = 0
        searchBar.resignFirstResponder()
        searchBar.text = ""
        UIView.animate(withDuration: 0.2, animations: {
            self.searchBar.isHidden = true
        }) { (_) in
        }
        selectedTab = "1"
        self.fetchCoinDetail(isShow: true, coinID: "")
    }
    
    @IBAction func coinButtonAction(_ sender : UIButton){
        allButtonBottomConstraint.constant = 0
        coinButtonBottomConstraint.constant = 3
        
        searchBar.resignFirstResponder()
        searchBar.text = ""
        UIView.animate(withDuration: 0.2, animations: {
            self.searchBar.isHidden = true
        }) { (_) in
        }
        selectedTab = "0"
        self.fetchCoinDetail(isShow: true, coinID: self.coinIds)
    }
}
extension HomeViewController {
    private func fetchCoinIds(isShowIndicator : Bool){
        guard isNetworkReachable() else {
            return
        }
        if(isShowIndicator){
            indicatorShow()
        }
        var url:String!
        url = Url.topCoinID.absoluteString!
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default
        ).responseJSON { (response) in
            switch response.result{
            case .success(let json):
                indicatorHide()
                print(json)
                guard let coinArray = json as? NSArray else{
                    return
                }
              
                for i in 0..<coinArray.count {
                    guard let coin = coinArray[i] as? [String:Any] else{
                        return
                    }
                    let id = coin["coinId"] as? String ?? ""
                    let coinDetails = CoinID(id: coin["coinId"] as? String ?? "", suggestion: coin["suggestion"] as? String ?? "")
                    self.arrCoinIds.append(coinDetails)
                    self.arrIds.append(id)
                }
                self.coinIds = self.arrIds.joined(separator: ",")
                if(self.selectedTab == "0"){
                    self.fetchCoinDetail(isShow : isShowIndicator , coinID : self.coinIds)
                }else{
                    self.fetchCoinDetail(isShow : isShowIndicator , coinID : "")
                }
            case .failure(let error):
                indicatorHide()
                print(error)
            }
        }
    }
    
    private func fetchCoinDetail(isShow : Bool , coinID : String){
        guard isNetworkReachable() else {
            return
        }
        var url:String!
        url = Url.coinDetail.absoluteString!
        var jsonData : NSDictionary =  NSDictionary()
        jsonData = [
            "vs_currency":"usd",
            "ids":coinID,
            "order":"market_cap_desc",
            "per_page":100,
            "page":1,
            "sparkline":false
        ]
        if(isShow){
            indicatorShow()
        }
        AF.request(
            url,
            method: .get,
            parameters: jsonData as? Parameters,
            encoding: URLEncoding.default
        ).responseJSON { (response) in
            switch response.result{
            case .success(let json):
                indicatorHide()
                print(json)
                guard let coinArray = json as? NSArray else{
                    return
                }
                self.arrCoins.removeAll()
                for i in 0..<coinArray.count {
                    guard let coin = coinArray[i] as? [String:Any] else{
                        return
                    }
                    let id = coin["id"] as? String
                    let index = self.arrCoinIds.firstIndex(where: { $0.id == id }) ?? 0
                                            
                    let coinDetail = Coin(id: "\(i+1)", coinImage: coin["image"] as? String ?? "", name: coin["symbol"] as? String  ?? "", coinName: coin["name"] as? String ?? "", coin24H: coin["high_24h"] as? Double ?? 0.0, price: coin["current_price"] as? Double ?? 0.0, marketCap: coin["market_cap"] as? Double ?? 0.0, marketCapRank: coin["market_cap_rank"] as? Int ?? 0, totalVolume: coin["total_volume"] as? Double ?? 0.0, totalSupply: coin["total_supply"] as? Double ?? 0.0, coin24HLow: coin["low_24h"] as? Double ?? 0.0,
                                          circulatingSupply : coin["circulating_supply"] as? Double ?? 0.0,
                                          suggestion: self.arrCoinIds[index].suggestion ?? "")
                 
                    self.arrCoins.append(coinDetail)
                }
                
                if(self.arrCoins.count > 0){
                    self.bindViewModel(coin: self.arrCoins)
                }
                
                
            case .failure(let error):
                print(error)
                indicatorHide()
            }
        }
    }
    
}

extension HomeViewController : CoinListTableViewAdapterDelegate {
    func selectCoin(Coin: Coin) {
        if let controller = UIStoryboard.main.instantiateViewController(withIdentifier: "CoinDetailViewController") as? CoinDetailViewController {
            controller.coin = Coin
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func filterPrice(max: Bool) {
        var coinArray = self.arrCoins
        self.arrCoins.removeAll()
        isPriceShowMax = max
        if(max){
            
            coinArray = coinArray.sorted(by: { (objModel, objModel1) -> Bool in return
                (Double(objModel.price)) > (Double(objModel1.price))
            })
        }else{
            coinArray = coinArray.sorted(by: { (objModel, objModel1) -> Bool in return
                (Double(objModel.price)) < (Double(objModel1.price))
            })
        }
        for i in 0..<coinArray.count {
            let coin = coinArray[i]
            let coinDetail = Coin(id: "\(i+1)", coinImage: coin.coinImage, name: coin.name, coinName: coin.coinName, coin24H: coin.coin24H, price: coin.price, marketCap: coin.marketCap, marketCapRank: coin.marketCapRank, totalVolume: coin.totalVolume, totalSupply: coin.totalSupply, coin24HLow: coin.coin24HLow, circulatingSupply: coin.circulatingSupply, suggestion: coin.suggestion)
            self.arrCoins.append(coinDetail)
        }
        self.bindViewModel(coin: self.arrCoins)
    }
    
    func filter24H(max: Bool) {
        is24HourwMax = max
        var coinArray = self.arrCoins
        self.arrCoins.removeAll()
        if(max){
            coinArray = coinArray.sorted(by: { (objModel, objModel1) -> Bool in return
                (Double(objModel.coin24H)) > (Double(objModel1.coin24H))
            })
        }else{
            coinArray = coinArray.sorted(by: { (objModel, objModel1) -> Bool in return
                (Double(objModel.coin24H)) < (Double(objModel1.coin24H))
            })
        }
        for i in 0..<coinArray.count {
            let coin = coinArray[i]
            let coinDetail = Coin(id: "\(i+1)", coinImage: coin.coinImage, name: coin.name, coinName: coin.coinName, coin24H: coin.coin24H, price: coin.price, marketCap: coin.marketCap, marketCapRank: coin.marketCapRank, totalVolume: coin.totalVolume, totalSupply: coin.totalSupply, coin24HLow: coin.coin24HLow, circulatingSupply: coin.circulatingSupply, suggestion: coin.suggestion)
            self.arrCoins.append(coinDetail)
        }
        self.bindViewModel(coin: self.arrCoins)
    }
    
    func filterMarketCap(max: Bool) {
        isMarketCapShowMax = max
        var coinArray = self.arrCoins
        self.arrCoins.removeAll()
        if(max){
            coinArray = coinArray.sorted(by: { (objModel, objModel1) -> Bool in return
                (Int(objModel.marketCapRank)) > (Int(objModel1.marketCapRank))
            })
        }else{
            coinArray = coinArray.sorted(by: { (objModel, objModel1) -> Bool in return
                (Int(objModel.marketCapRank)) < (Int(objModel1.marketCapRank))
            })
        }
        for i in 0..<coinArray.count {
            let coin = coinArray[i]
            let coinDetail = Coin(id: "\(i+1)", coinImage: coin.coinImage, name: coin.name, coinName: coin.coinName, coin24H: coin.coin24H, price: coin.price, marketCap: coin.marketCap, marketCapRank: coin.marketCapRank, totalVolume: coin.totalVolume, totalSupply: coin.totalSupply, coin24HLow: coin.coin24HLow, circulatingSupply: coin.circulatingSupply, suggestion: coin.suggestion)
            self.arrCoins.append(coinDetail)
        }
        self.bindViewModel(coin: self.arrCoins)
    }
}

extension HomeViewController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        searchBar.text = ""
        
        UIView.animate(withDuration: 0.2, animations: {

            self.searchBar.isHidden = true
        }) { (_) in
            
            self.adapterCoinList?.Items = self.arrCoins
            
        }
        
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar(searchBar, textDidChange: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var all :[Coin] = []
        
        guard searchText.count > 0 else {
            adapterCoinList?.Items = self.arrCoins
            return
        }
        
        for data in self.arrCoins{
            all.append(data)
        }
        
        all = all.filter({ $0.coinName.range(of: searchBar.text!, options: .caseInsensitive) != nil })
        
        self.adapterCoinList?.Items = all
    }
}
