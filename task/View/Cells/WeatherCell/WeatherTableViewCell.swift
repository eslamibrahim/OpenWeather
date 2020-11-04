//
//  WeatherTableViewCell.swift
//  WeatherAppMVC
//
//  Created by OSX on 9/11/19.
//  Copyright © 2019 eslam. All rights reserved.
//

import UIKit
import Kingfisher
class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var describtion: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var tempr: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configurationCell( city : String ,weather : WeatherInfo)  {
        
        describtion.text =  weather.weather?[0]._description
        date.text = weather.dateText?.getFormattedDate()
        tempr.text = weather.aboutTemperature!.tempMax?.temperatureConvertorKelvinToCelsius()
        let url = URL(string: weather.iconUrlPath)
        icon.downloadImageWithCaching(with: url?.absoluteString ?? "", placeholderImage: UIImage(named: "Placeholder"))
    }

}
