//
//  WeatherDetailsViewModel.swift
//  task
//
//  Created by islam on 11/4/20.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class WeatherDetailsViewModel: BaseViewModel {
    
    private let dependencies: Dependencies
    var weathersData: BehaviorRelay<[WeatherInfo]> = BehaviorRelay(value: [])
    var TableData: Observable<[WeatherInfo]>
    let data : WeatherDetails
    var managedObjectContext: NSManagedObjectContext!

    init(dependencies: Dependencies , data: WeatherDetails) {
        self.dependencies = dependencies
        self.data = data
        self.TableData = weathersData.asObservable()
        self.weathersData.accept(data.weatherInfo ?? [])
        self.managedObjectContext = dependencies.managedObjectContext
        super.init()
    }
    
}
