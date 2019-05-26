//
//  LocationManager.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import RxCoreLocation
import CoreLocation
import RxSwift

class LocationManager {
    
     var manager = CLLocationManager()
    private var bag = DisposeBag()
    
    private var lat:CLLocationDegrees!
    private var lng:CLLocationDegrees!
    
    init() {
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        setup()
        
    }
    
    func setup() {
        
        manager.rx
            .didUpdateLocations
            .debug("didUpdateLocations")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to didChangeAuthorization
        manager.rx
            .didChangeAuthorization
            .debug("didChangeAuthorization")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        /// Subscribe to placemark
        manager.rx
            .placemark
            .debug("placemark")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .placemark
            .subscribe(onNext: { placemark in
                guard let name = placemark.name,
                    let isoCountryCode = placemark.isoCountryCode,
                    let country = placemark.country,
                    let postalCode = placemark.postalCode,
                    let locality = placemark.locality,
                    let subLocality = placemark.subLocality else {
                        return print("oops it looks like your placemark could not be computed")
                }
                print("name: \(name)")
                print("isoCountryCode: \(isoCountryCode)")
                print("country: \(country)")
                print("postalCode: \(postalCode)")
                print("locality: \(locality)")
                print("subLocality: \(subLocality)")
            })
            .disposed(by: bag)
    }
   
    
    
}
