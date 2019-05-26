//
//  AppDelegate.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        configureDependencies()
        
        return true
    }

    func configureDependencies() {
        let networkManager = NetworkManager.sharedInstance

        
        _ = networkManager.startNetworkReachabilityObserver()
            .subscribe(onNext: { reachable in
                if reachable == false {
                    print("No Network")
                    self.displayNetworkAlert()
                }
            })
    }
    
    func displayNetworkAlert() {
        let alertController = UIAlertController(title: "Error", message: "No Internet connection.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

    
}

