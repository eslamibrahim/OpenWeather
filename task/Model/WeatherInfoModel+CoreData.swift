

import Foundation
import CoreData
import RxDataSources
import RxCoreData


struct WeatherInfoCoredataModel {
    var id : Int32?
    var city : CityModel?
    var weatherInfo : [WeatherInfo]?
    var date = Date()
    

    init(weatherDetails: WeatherDetails) {
        self.city = weatherDetails.city
        self.weatherInfo = weatherDetails.weatherInfo
        self.id = Int32(weatherDetails.city?.id ?? 0)
    }
}

func == (lhs: WeatherInfoCoredataModel, rhs: WeatherInfoCoredataModel) -> Bool {
    return lhs.id == rhs.id
}

extension WeatherInfoCoredataModel : Equatable { }

extension WeatherInfoCoredataModel : IdentifiableType {
    typealias Identity = String
    
    var identity: Identity {
        return "\(String(describing: id!))"
    }
}

extension WeatherInfoCoredataModel : Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "WeatherTable"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        
        id = entity.value(forKey: "id") as? Int32
        city = entity.value(forKey: "city") as? CityModel
        weatherInfo = entity.value(forKey: "weatherInfo") as? [WeatherInfo]
        date = entity.value(forKey: "date") as! Date
    }

    func update(_ entity: T) {
        
        entity.setValue(city, forKey: "city")
        entity.setValue(weatherInfo, forKey: "weatherInfo")
        entity.setValue(id, forKey: "id")
        entity.setValue(date, forKey: "date")

        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}
