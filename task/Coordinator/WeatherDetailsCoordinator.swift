//
//  WeatherDetailsCoordinator.swift
//  task
//
//  Created by islam on 11/4/20.
//

import Foundation
import RxSwift
import UIKit
import PopupDialog

class WeatherDetailsCoordinator: Coordinator<Void> {
    
    private let navigationController: UINavigationController
    private let dependencies:Dependencies
    let data: WeatherDetails
    init(navigationController: UINavigationController ,dependencies:Dependencies, data: WeatherDetails) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.data = data
    }
    
    override func start() -> Observable<Void> {
        let viewController = UIStoryboard.main.weatherViewController
        let viewModel = WeatherDetailsViewModel(dependencies: dependencies, data: data)
        viewController.viewModel = viewModel
        let popupDialog = PopupDialog(viewController: viewController)
        navigationController.present(popupDialog, animated: true, completion: nil)
        return Observable.empty()
    }
    
    deinit {
        plog(WeatherDetailsCoordinator.self)
    }
}
