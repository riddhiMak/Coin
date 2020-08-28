
import Foundation
import UIKit


enum Url {
    
    static let topCoinID = NSURL(string: "http://crypto-vestor-bot-django-env.eba-njywnk3q.us-west-2.elasticbeanstalk.com/adminApis/topCoins/?ordering=rank")!
    static let coinDetail = NSURL(string: "https://api.coingecko.com/api/v3/coins/markets")!
    
}

//Never user Color enum directly, use UIColor's Extenion's property only
enum Color {
    static let primary = UIColor(named: "primary")
    
    static let primaryText = UIColor(named: "primaryText")
    static let secondaryText = UIColor(named: "secondaryText")
    static let secondaryDarkText = UIColor(named: "secondaryDarkText")
    
    static let background = UIColor(named: "background")
    static let border = UIColor(named: "border")
}

//MARK: -- Indicator --
func indicatorShow(){
    let size = CGSize(width: 30, height: 30)
    act_indicator.startAnimating(size, message: "", type: NVActivityIndicatorType(rawValue:16)!)
}
func indicatorHide(){
    act_indicator.stopAnimating()
}
