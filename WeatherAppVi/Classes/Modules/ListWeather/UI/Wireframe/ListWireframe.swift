//
//  ListWireframe.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit

class ListWireframe : NSObject {
    
    let ListViewControllerIdentifier = "ListViewController"
    
    var detailWireframe : DetailWireframe?
    
    var listPresenter : ListPresenter?
    
    var listWeatherViewController : UIViewController?

    init(vc:UIViewController) {
        super.init()
        detailWireframe = DetailWireframe()
        
        listWeatherViewController = vc
        
    }
    
    func showDetailViewController(withWeather weather: Weather) {
//        let detailDataManager = DetailDataManager()
        
        //let detailInteractor = DetailsInteractor(detailDataManager: detailDataManager)
        
        let detailInteractor = DetailsInteractor()
        
        
        let detailPresenter = DetailsPresenter()
        detailPresenter.detailInteractor = detailInteractor
        detailPresenter.detailWireframe = detailWireframe
        
        detailWireframe?.detailPresenter = detailPresenter
        detailWireframe?.presentDetailInterface(fromViewController: listWeatherViewController!, withWeather: weather)
    }
    
}
