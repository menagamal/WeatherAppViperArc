//
//  NetworkManager.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//


import Foundation
import RxAlamofire
import Alamofire
import RxSwift
import ObjectMapper
import RxSwift

class NetworkManager : NSObject {
    
    static let sharedInstance = NetworkManager()
    var disposeBag: DisposeBag = DisposeBag()
    
    let weatherURL = "\(baseURL)APPID=\(API_KEY)&"

    var isReachable = false
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    let manager = SessionManager.default
    
    override init() {
        super.init()
    }
    
    func startNetworkReachabilityObserver() -> Observable<Bool> {
        return Observable.create { observer in
            
            self.reachabilityManager?.listener = { status in
                
                switch status {
                    
                case .notReachable:
                    self.isReachable = false
                    print("The network is not reachable")
                    
                case .unknown :
                    self.isReachable = false
                    print("It is unknown whether the network is reachable")
                    
                case .reachable:
                    self.isReachable = true
                    //            case .Reachable(.EthernetOrWiFi):
                    //                print("The network is reachable over the WiFi connection")
                    
                    //            case .Reachable(.WWAN):
                    //                print("The network is reachable over the WWAN connection")
                    
                }
                
                observer.onNext(self.isReachable)
            }
            
            // start listening
            self.reachabilityManager?.startListening()
            
            return Disposables.create()
        }
        
    }
    
    func fetchWeather(url: String?)  -> Observable<Weather> {

        var stringURL = weatherURL
        if (url != nil) {
            stringURL = weatherURL +  url!
        }
      
        return Observable.create { observer in
            _ = self.manager.rx.request(.get, stringURL)
                .flatMap {
                    $0
                        .validate(statusCode: 200 ..< 300)
                        .rx.responseJSON()
                }
                //.mapObject(type: Weather.self)
                .subscribe (
                    onNext: { weather in
                        if let json = weather.data  {
                            
                            do {
                                let object = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String: Any]
                                let weather = Weather(json: object!)
                                
                                observer.onNext(weather)
                            } catch {
                                observer.onError(error)
                            }

                        }
                       
                },
                    onError: { error in
                        observer.onError(error)
                })
                
                .addDisposableTo(self.disposeBag)
            
            return Disposables.create()
        }
        
    }
    
}
