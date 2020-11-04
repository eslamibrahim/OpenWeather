//
//  task
//
//  Created by islam on 9/23/20.
//

import Foundation
import Alamofire


enum APIRouter:URLRequestConvertible {
    
    case getForecastWeather(cityId : Int)
    case getForecastWeatherByLatLng(lat: String, lng: String)
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .getForecastWeather, .getForecastWeatherByLatLng:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .getForecastWeather:
                return nil
            case .getForecastWeatherByLatLng:
                return nil
            }
        }()
        
        let url: URL = {
            
            // Add base url for the request
            let baseURL:String = {
                return Environment.APIBasePath()
            }()
            
            let apiVersion: String? = {
                return Environment.APIVersionPath()
            }()
            
            // build up and return the URL for each endpoint
            let relativePath: String? = {
                switch self {
                case .getForecastWeather(let cityId):
                    return "forecast?id=\(cityId)&appid\(apiKey)"
                case .getForecastWeatherByLatLng(let lat, let lng):
                    return "forecast?lat=\(lat)&lon=\(lng)&appid\(apiKey)"
                }
            }()

            var urlWithAPIVersion = baseURL
            
            if let apiVersion = apiVersion {
                urlWithAPIVersion = urlWithAPIVersion + apiVersion
            }
            
            let url = URL(string: urlWithAPIVersion + (relativePath ?? ""))!

            return url
        }()
        
        let encoding:ParameterEncoding = {
            return URLEncoding.default
        }()
        
        let headers:[String:String]? = {
            return nil
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        let _url = try encoding.encode(urlRequest, with: params)
        
        return _url
    }
}
