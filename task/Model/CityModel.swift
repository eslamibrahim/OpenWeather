//
//  CityModel.swift
//  WeatherAppMVC
//
//  Created by OSX on 9/10/19.
//  Copyright © 2019 eslam. All rights reserved.
//

import Foundation


class CityModel: NSObject, Codable , NSCoding{

    var id : Int?
    var name :String?
    var  country_code : String?
   private enum CodingKeys: String, CodingKey {
        case name, country_code = "country", id
    }
    
    init(id : Int, name :String) {
        self.id = id
        self.name = name
    }
    
    required convenience init(coder aDecoder: NSCoder) {
      let id = aDecoder.decodeObject(forKey: "id") as! Int
      let  name = aDecoder.decodeObject(forKey: "name") as! String
      self.init(id : id, name :name)
  }

  func encode(with coder: NSCoder) {
      coder.encode(name, forKey: "name")
      coder.encode(id, forKey: "id")
  }

}
