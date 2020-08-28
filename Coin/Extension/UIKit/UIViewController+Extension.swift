
import Foundation
import UIKit
import Alamofire
import MBProgressHUD

protocol UIViewControllerReachabilityDelegate {
    func networkReachabilityChanged(status: Alamofire.NetworkReachabilityManager.NetworkReachabilityStatus)
}

extension UIViewController {
    
    //MARK: - Network
    func isNetworkReachable() -> Bool{
        return NetworkReachabilityManager(host: "https://www.google.com")?.isReachable ?? false
    }
    
    func setReachabilityDelegate() {
        NetworkReachabilityManager()?.startListening(onUpdatePerforming: { (networkReachabilityStatus) in
            if let controller = self as? UIViewControllerReachabilityDelegate{
                controller.networkReachabilityChanged(status: networkReachabilityStatus)
            }
        })
    }
    
    //MARK: - HUD
    func showHUD(){
        
        DispatchQueue.main.async {
            
            var viewToAdd = self.view
            
            if let window = UIApplication.shared.windows.last {
                viewToAdd = window
            }
            else if let navigationController = self.navigationController{
                viewToAdd = navigationController.view
            }
            
            let hud:MBProgressHUD = MBProgressHUD.showAdded(to: viewToAdd!, animated: true)
            hud.bezelView.blurEffectStyle = .dark
            hud.backgroundView.color = .init(white: 0.0, alpha: 0.1)
            hud.contentColor = UIColor.background
            hud.show(animated: true)

        }
    }
    
    func hideHUD(){
        
        DispatchQueue.main.async {
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if let window = UIApplication.shared.windows.last {
                MBProgressHUD.hide(for: window, animated: true)
            }
            
            if let navigationController = self.navigationController{
                MBProgressHUD.hide(for: navigationController.view, animated: true)
            }
        }
    }
    
    func showHUDInView(){
        
        DispatchQueue.main.async {
            
            var viewToAdd = self.view
            
            if let navigationController = self.navigationController{
                viewToAdd = navigationController.view
            }
            
            let hud:MBProgressHUD = MBProgressHUD.showAdded(to: viewToAdd!, animated: true)
            hud.bezelView.blurEffectStyle = .dark
            hud.backgroundView.color = .init(white: 0.0, alpha: 0.1)
            hud.contentColor = UIColor.background
            hud.show(animated: true)

        }
    }
    
    func showMessage(message:String){
        
        DispatchQueue.main.async {
            
            var viewToAdd = self.view
            
            if let window = UIApplication.shared.windows.first {
                viewToAdd = window
            }
            else if let navigationController = self.navigationController{
                viewToAdd = navigationController.view
            }
            
            let hud:MBProgressHUD = MBProgressHUD.showAdded(to: viewToAdd!, animated: true)
            hud.mode = .text
            hud.label.text = message
            hud.label.numberOfLines = 0
            hud.offset = .zero
            hud.bezelView.blurEffectStyle = .dark
            hud.backgroundView.color = .init(white: 0.0, alpha: 0.1)
            hud.contentColor = UIColor.background
            hud.show(animated: true)
            hud.hide(animated: true, afterDelay: 1.5)

        }
    }

}


