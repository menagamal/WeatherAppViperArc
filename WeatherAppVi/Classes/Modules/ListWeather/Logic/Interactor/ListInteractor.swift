//
//  ListInteractor.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import RxSwift

class ListInteractor:NSObject  {
    
    let networkManager  = NetworkManager.sharedInstance
    var disposeBag: DisposeBag = DisposeBag()
    
    var weatherArray: Variable<[Weather]> = Variable([])
    
    var locationManager:LocationManager!
    
    //    init(dataManager: ListDataManager) {
    //        self.dataManager = dataManager
    //    }
    
    override init() {
        super.init()
        
    }
    
    func fetchCurrentLocationWeather() -> Observable<Weather> {
        
        
        return Observable.create { observer in
            
            if let location = self.locationManager.manager.location {
                
                _ = self.networkManager.fetchWeather(url: "lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)")
                    .subscribe (
                        onNext: { weather in
                            
                            self.update(weather: weather)
                            observer.onNext(weather)
                    },
                        onError: { error in
                            print("Some error in ListInteractor pa: \(error.localizedDescription)")
                            observer.onError(error)
                    })
                    .addDisposableTo(self.disposeBag)
                
            }
            
            return Disposables.create()
        }
    }
    
    
    func fetchCityWeather(city:String) -> Observable<Weather> {
        
        return Observable.create { observer in
            _ = self.networkManager.fetchWeather(url: "q=\(city)")
                .subscribe (
                    onNext: { weather in
                        
                        self.update(weather: weather)
                        observer.onNext(weather)
                },
                    onError: { error in
                        print("Some error in ListInteractor pa: \(error.localizedDescription)")
                        observer.onError(error)
                })
                .addDisposableTo(self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func update(weather: Weather) {
        self.weatherArray.value.append(weather)
    }
    
    
}
