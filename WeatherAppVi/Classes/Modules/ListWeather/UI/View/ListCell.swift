//
//  ListCell.swift
//  WeatherAppViper
//
//  Created by Mena Gamal on 5/25/19.
//  Copyright © 2019 Mena Gamal. All rights reserved.
//

import UIKit
import SDWebImage

class ListCell: UITableViewCell {

    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var labelCityName: UILabel!
    static let Identifier = "ListCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDetails(item:Weather)  {
        labelCityName.text = item.city.name
        labelTemp.text = item.temp
        let imgUrl = "http://openweathermap.org/img/w/\(item.icon!).png"
        weatherIcon?.sd_setImage(with: URL(string: imgUrl), completed: nil)
        
    }

   

}
