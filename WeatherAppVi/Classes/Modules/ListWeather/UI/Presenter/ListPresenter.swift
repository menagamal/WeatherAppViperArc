//
//  ListPresenter.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import CoreLocation


class ListPresenter :NSObject {
    
    var listWireframe : ListWireframe?
    
    var listInteractor : ListInteractor?
    
    var detailWireframe : DetailWireframe?
    
    var userInterface : ListWeatherViewController?
    
    let disposeBag = DisposeBag()
    
    var locationManager = LocationManager()
    

    init(vc:ListWeatherViewController) {
        super.init()
        self.userInterface = vc
        self.listInteractor = ListInteractor()
        self.listInteractor?.locationManager = locationManager
        self.listWireframe = ListWireframe(vc: vc)

    }
    
    func updateUserInterfaceWithContacts(_ allCitiesWeather: [Weather]) {
        userInterface?.showAllCitiesWeather(allCitiesWeather)
        
    }
    
    
    func fetchDataFromServer()  {
        
        listInteractor?.weatherArray.value.removeAll()
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                fetchFirstCity()
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                fetchCurrentLocationWeather()
            }
        } else {
            print("Location services are not enabled")
        }
        
        
    }
    
    private func fetchCurrentLocationWeather() {
        let _ = listInteractor?.fetchCurrentLocationWeather()
            .subscribe(
                onNext: { weather in
                    self.updateView()
                    self.fetchFirstCity()
                    
            },
                onError: { error in
                    self.fetchFirstCity()
                    
                    print("Some error in AddPresenter pa: \(error)")
            })
        
    }
    
    
   private func fetchFirstCity() {
        let _ = listInteractor?.fetchCityWeather(city: FIRST_CITY_TO_SEARCH)
            .subscribe(
                onNext: { weather in
                    self.updateView()
                  self.fetchSecondCity()
            },
                onError: { error in
                    self.fetchSecondCity()
                    print("Some error in AddPresenter pa: \(error)")
            })
    }
    
   private func fetchSecondCity() {
        _ = listInteractor?.fetchCityWeather(city: SECOND_CITY_TO_SEARCH)
            .subscribe(
                onNext: { weather in
                    self.updateView()

            },
                onError: { error in
                    print("Some error in AddPresenter pa: \(error)")
//                    self.listWireframe?.displayAlert()
            })
    }
    
    func updateView() {
        
        listInteractor?.weatherArray.asObservable().subscribe( {onNext in
            guard let contacts = self.listInteractor?.weatherArray else {
                return
            }
            self.updateUserInterfaceWithContacts(contacts.value)
        })
            .disposed(by: disposeBag)
    }
    
    func showDetail(weather: Weather){
        listWireframe!.showDetailViewController(withWeather: weather)
    }

    
}
