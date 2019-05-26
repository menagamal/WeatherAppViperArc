//
//  DetailsViewController.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelWeatherDesc: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelCloud: UILabel!
    
    var eventHandler : DetailsPresenter?
    
    var weather: Weather!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout() {
        navigationItem.title = "Detail"
        
        labelCity.text = weather.city.name
        labelTemp.text = weather.temp
        labelWind.text = weather.windsSpeed
        labelCloud.text =  weather.clouds
        labelWeatherDesc.text = weather.weatherDescription
        let imgUrl = "http://openweathermap.org/img/w/\(weather.icon!).png"
        weatherIcon?.sd_setImage(with: URL(string: imgUrl), completed: nil)

        
    }
    
    
}

