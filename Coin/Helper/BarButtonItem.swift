//
//  BarButtonItem.swift
//  Coin
//
//  Created by riddhi  on 01/08/20.
//  Copyright © 2020 Riddhi. All rights reserved.
//

import UIKit

class UIBarButtonItemWithClouser: UIBarButtonItem {

    private var actionHandler: (() -> Void)?
    
    convenience init(title: String?, style: UIBarButtonItem.Style, actionHandler: (() -> Void)?) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(barButtonItemPressed(sender:))
        self.actionHandler = actionHandler
    }
    
    convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, actionHandler: (() -> Void)?) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(barButtonItemPressed(sender:))
        self.actionHandler = actionHandler
    }
    
    convenience init(button: UIButton, actionHandler: (() -> Void)?) {
        self.init(customView: button)
        button.addTarget(self, action: #selector(barButtonItemPressed(sender:)), for: .touchUpInside)
        self.actionHandler = actionHandler
    }
    
    @objc private func barButtonItemPressed(sender: UIBarButtonItem) {
        if let actionHandler = self.actionHandler {
            actionHandler()
        }
    }
}
