//  task
//
//  Created by islam on 9/23/20.
//

import UIKit
import RxSwift
import CoreData

final class AppCoordinator: Coordinator<Void> {
    
    private let navigationController:UINavigationController
    private let window: UIWindow
    let dependencies: AppDependency
    
    init(window:UIWindow, navigationController:UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.dependencies = AppDependency(window: self.window, managedContext: Application.managedObjectContext)
    }
    
    override func start() -> Observable<Void> {
        // Show Movie list screen
        return showHome()
    }
    
    private func showHome() -> Observable<Void> {
        let rootCoordinator = RootCoordinator(navigationController: navigationController, dependencies: self.dependencies)
        return coordinate(to: rootCoordinator)
    }
    
    
    deinit {
        plog(AppCoordinator.self)
    }
    
}

class RootCoordinator: Coordinator<Void>{
    typealias Dependencies = HasWindow & HasAPI & HasCoreData
    
    private let rootNavigationController:UINavigationController
    private let dependencies: Dependencies
    
    init(navigationController:UINavigationController, dependencies: Dependencies) {
        self.rootNavigationController = navigationController
        self.dependencies = dependencies
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewModel = HomeViewModel(dependencies: self.dependencies)
        let viewController = UIStoryboard.main.homeViewController
        viewController.viewModel = viewModel
        viewModel.selectWeathersData.asObservable().subscribe(onNext: { (item,count) in
            self.showWeatherDetails(data: item, localDataCount: count)
        }).disposed(by: disposeBag)
        rootNavigationController.pushViewController(viewController, animated: true)
        dependencies.window.rootViewController = rootNavigationController
        dependencies.window.makeKeyAndVisible()
        return Observable.never()
    }

    private func showWeatherDetails(data: WeatherDetails,localDataCount : Int) -> Observable<Void> {
        let weatherDetailsCoordinator = WeatherDetailsCoordinator(navigationController: rootNavigationController, dependencies: self.dependencies, data: data, localDataCount: localDataCount)
        return coordinate(to: weatherDetailsCoordinator)
       return  Observable.never()
    }
    
    deinit {
        plog(RootCoordinator.self)
    }
}

