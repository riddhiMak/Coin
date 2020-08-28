//
//  Common.swift
//  Coin
//
//  Created by riddhi  on 01/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Property

var sharedDelegate: AppDelegate = {
    return UIApplication.shared.delegate as! AppDelegate
}()

var safeAreaInset: UIEdgeInsets = {
    
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.keyWindow
        return window!.safeAreaInsets
    }
    else{
        return UIEdgeInsets.zero
    }
}()

var screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)


let iOS13: Bool = {
    if #available(iOS 13.0, *) {
        return true
    }
    else{
        return false
    }
}()

fileprivate let whiteImage = UIImage(color: UIColor.background!)

func setNavigationBarFor(controller: UIViewController,
                         title:String = "",
                         isTransperent:Bool = false,
                         hideShadowImage: Bool = false,
                         backActionHandler: (() -> Void)? = nil) {
     
    guard let navigationController = controller.navigationController else{
        return
    }
    
    controller.title = title

    navigationController.navigationBar.barTintColor = UIColor.primary
    navigationController.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white as Any,
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
    
    
    if let action = backActionHandler {
        
        navigationController.navigationItem.setHidesBackButton(true, animated: false)
        
        let backButtonItem = UIBarButtonItemWithClouser(image: UIImage(named: "icon_back"), landscapeImagePhone: nil, style: .plain, actionHandler: action)
        backButtonItem.tintColor = .white
        controller.navigationItem.leftBarButtonItem = backButtonItem
    }
}
