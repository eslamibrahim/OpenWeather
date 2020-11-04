//
//  ParseCitiesJsonFile.swift
//  WeatherAppMVC
//
//  Created by OSX on 9/10/19.
//  Copyright © 2019 eslam. All rights reserved.
//

import Foundation


class JsonHelper {
    
    
    static func loadAllCitiesFromFile (completion : @escaping (_ message : String? , _ result :[CityModel]?) -> ()){
        
        if let path = Bundle.main.path(forResource: "city_list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONDecoder().decode([CityModel].self, from: data)
                
  
                completion(nil , jsonResult)
                
            } catch let error as NSError{
                completion(error.localizedDescription , nil)
                print(error.localizedDescription)
            }
        }
    }
}
