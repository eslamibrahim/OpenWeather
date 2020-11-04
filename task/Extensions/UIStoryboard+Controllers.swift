//
//  task
//
//  Created by islam on 9/23/20.
//
import Foundation
import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

}


extension UIStoryboard {
    
    
    var homeViewController: HomeViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController else {
            fatalError(String(describing: HomeViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    
    var weatherViewController: WeatherViewController {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: WeatherViewController.self)) as? WeatherViewController else {
            fatalError(String(describing: WeatherViewController.self) + "\(NSLocalizedString("couldn't be found in Storyboard file", comment: ""))")
        }
        return viewController
    }
    
    
    
}
