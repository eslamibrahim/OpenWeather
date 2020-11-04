//  task
//
//  Created by islam on 9/23/20.
//


import Foundation

enum Server {
    case developement
    case staging
    case production
}

class Environment {

    static let server:Server    =   .developement
    
    // To print the log set true.
    static let debug:Bool       =   true
    
    class func APIBasePath() -> String {
        switch self.server {
            case .developement:
               return  "https://api.openweathermap.org/data/2.5/"
            case .staging:
                return ""
            case .production:
                return ""
        }
    }
    
    class func APIVersionPath() -> String {
        switch self.server {
        case .developement:
            return ""
        case .staging:
            return ""
        case .production:
            return ""
        }
    }
    
    
}


