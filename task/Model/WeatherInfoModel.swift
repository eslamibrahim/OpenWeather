//
//  Created by OSX on 9/9/19.
//  Copyright © 2019 eslam. All rights reserved.

import Foundation


class  WeatherDetails : NSObject, NSCoding, Codable{
    
    var city : CityModel?
    var weatherInfo : [WeatherInfo]?
    private enum CodingKeys: String, CodingKey {
        case  weatherInfo = "list", city = "city"
    }
    
    init(response: [String: Any]?) {
        guard let response = response else {
            return
        }
        if let weatherDetailData = try? JSONSerialization.data(withJSONObject: response, options: []) {
            let weatherDetailResponse = try? JSONDecoder().decode(WeatherDetails.self, from: weatherDetailData)
            self.city = weatherDetailResponse?.city
            self.weatherInfo = weatherDetailResponse?.weatherInfo
        }
    }
    init(weatherDetails: WeatherInfoCoredataModel) {
        self.city = weatherDetails.city
        self.weatherInfo = weatherDetails.weatherInfo
    }
    
    init(city : CityModel, weatherInfo : [WeatherInfo]) {
        self.city = city
        self.weatherInfo = weatherInfo
    }
    
    required convenience init(coder aDecoder: NSCoder) {
      let city = aDecoder.decodeObject(forKey: "city") as! CityModel
      let weatherInfo = aDecoder.decodeObject(forKey: "weatherInfo") as! [WeatherInfo]
      self.init(city : city, weatherInfo : weatherInfo)
  }

  func encode(with coder: NSCoder) {
      coder.encode(city, forKey: "city")
      coder.encode(weatherInfo, forKey: "weatherInfo")
  }
}

class WeatherInfo : NSObject, NSCoding, Codable{
    
    var weather : [Weather]?
    var aboutTemperature : AboutTemperature?
    var dateText: String?
    private enum CodingKeys: String, CodingKey {
        case  weather, aboutTemperature = "main" , dateText = "dt_txt"
    }
    
    init(weather : [Weather], aboutTemperature : AboutTemperature, dateText: String) {
        self.weather = weather
        self.aboutTemperature = aboutTemperature
        self.dateText = dateText
    }
    
    required convenience init(coder aDecoder: NSCoder) {
      let dateText = aDecoder.decodeObject(forKey: "dateText") as! String
      let  aboutTemperature = aDecoder.decodeObject(forKey: "aboutTemperature") as! AboutTemperature
      let   weather = aDecoder.decodeObject(forKey: "weather") as! [Weather]
      self.init(weather : weather, aboutTemperature : aboutTemperature, dateText: dateText)
  }

  func encode(with coder: NSCoder) {
      coder.encode(dateText, forKey: "dateText")
      coder.encode(aboutTemperature, forKey: "aboutTemperature")
      coder.encode(weather, forKey: "weather")
  }
    
}

class Weather: NSObject, NSCoding, Codable {
    
    var _description: String?
    var icon: String?
    
    init(description: String, icon: String) {
        self._description = description
        self.icon = icon
    }
    private enum CodingKeys: String, CodingKey {
        case  _description = "description", icon
    }
    required convenience init(coder aDecoder: NSCoder) {
      let _description = aDecoder.decodeObject(forKey: "_description") as! String
      let  icon = aDecoder.decodeObject(forKey: "icon") as! String
      self.init(description: _description, icon: icon)
  }

  func encode(with coder: NSCoder) {
      coder.encode(_description, forKey: "_description")
      coder.encode(icon, forKey: "icon")
  }
    
}

class AboutTemperature:NSObject, NSCoding, Codable {
    var temp: Double?
    var tempMax: Double?
    var tempMin: Double?
    private enum CodingKeys: String, CodingKey {
        case temp, tempMax = "temp_max", tempMin = "temp_min"
    }
    init(tempMin: Double, temp: Double, tempMax: Double) {
        self.tempMin = tempMin
        self.temp = temp
        self.tempMax = tempMax
    }
    
    required convenience init(coder aDecoder: NSCoder) {
      let temp = aDecoder.decodeObject(forKey: "temp") as! Double
      let  tempMax = aDecoder.decodeObject(forKey: "tempMax") as! Double
      let  tempMin = aDecoder.decodeObject(forKey: "tempMin") as! Double
      self.init(tempMin: tempMin, temp: temp, tempMax: tempMax)
  }

  func encode(with coder: NSCoder) {
      coder.encode(temp, forKey: "temp")
      coder.encode(tempMax, forKey: "tempMax")
     coder.encode(tempMin, forKey: "tempMin")
  }
}

extension WeatherInfo  {
    var iconUrlPath: String {
        guard let iconName = weather?.first?.icon else { return "" }
        return "https://openweathermap.org/img/w/\(iconName).png"
    }
    
    var displayTemperature: Int {
        let value = Int(round(aboutTemperature?.temp ?? 0))
        return value
    }
    
    var displayTemperatureMax: Int {
        let value = Int(round(aboutTemperature?.tempMax ?? 0))
        return value
    }
    
    var displayTemperatureMin: Int {
        let value = Int(round(aboutTemperature?.tempMin ?? 0))
        return value
    }
    
    var weatherDescription: String {
        guard let weatherDescription = weather?.first?.description else { return "" }
        return weatherDescription
    }
}



