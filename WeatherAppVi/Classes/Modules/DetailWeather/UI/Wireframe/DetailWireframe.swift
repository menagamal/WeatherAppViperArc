//
//  DetailWireframe.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class DetailWireframe : NSObject {
    
    let DetailViewControllerIdentifier = "DetailViewController"
    
    var detailPresenter : DetailsPresenter?
    var presentedViewController : DetailsViewController?
    
    override init() {
        super.init()
    }
    
    
    func presentDetailInterface(fromViewController viewController: UIViewController, withWeather weather: Weather) {
        
        let newViewController = detailViewControllerFromStoryboard()
        newViewController.eventHandler = detailPresenter
        newViewController.weather = weather
        detailPresenter!.userInterface = newViewController
        viewController.navigationController?.pushViewController(newViewController, animated: true)
        
        presentedViewController = newViewController
    }
    
    func detailViewControllerFromStoryboard() -> DetailsViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: DetailViewControllerIdentifier) as! DetailsViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
}
