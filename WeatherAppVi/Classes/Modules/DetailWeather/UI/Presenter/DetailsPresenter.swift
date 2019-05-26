//
//  DetailsPresenter.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import RxSwift

class DetailsPresenter: NSObject {
    
    var detailInteractor : DetailsInteractor?
    var detailWireframe : DetailWireframe?
    var userInterface : DetailsViewController?
    var disposeBag: DisposeBag = DisposeBag()
    
}
