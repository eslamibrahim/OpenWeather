//
//  HomeViewModel.swift
//  task
//
//  Created by islam on 9/24/20.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import CoreData


typealias Dependencies = HasAPI & HasCoreData

typealias CompletionWeatherObjectAndLocalDataCount = (data : WeatherDetails ,count : Int)

class HomeViewModel: BaseViewModel {
    
    // Dependencies
    private let dependencies: Dependencies
    var managedObjectContext: NSManagedObjectContext!
    
    /// Network request in progress
    let isLoading: ActivityIndicator =  ActivityIndicator()
    
    //API Result
    var getWeatherData: Observable<APIResult<WeatherDetails>> {
        return _getWeatherData.asObservable().observeOn(MainScheduler.instance)
    }
    private let _getWeatherData = ReplaySubject<APIResult<WeatherDetails>>.create(bufferSize: 1)

    var weathersData: BehaviorRelay<[WeatherDetails]> = BehaviorRelay(value: [])

    var locationManager : LocationService = LocationService()
        
    var selectWeathersData = PublishSubject<CompletionWeatherObjectAndLocalDataCount>()
    var TableData: Observable<[WeatherDetails]>
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.managedObjectContext = dependencies.managedObjectContext
        self.TableData = weathersData.asObservable()

        super.init()

        getWeatherData
            .subscribe(onNext: { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .success(let response):
                    if UserDefaults.isFirstApiCall(){
                 _ = try? self.managedObjectContext.rx.update(WeatherInfoCoredataModel(weatherDetails: response))
                    }
                    else{
                        self.selectWeathersData.onNext((data :response , count : self.weathersData.value.count))
                    }
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        getweathersFromCoreData()
    }
    
    func loadAllCities (completion : @escaping (_ result :[CityModel]?) -> ()) {
        JsonHelper.loadAllCitiesFromFile { [ weak self]( errorMessage , result) in
                completion(result)
        }
    }
    
    
        
}

//MARK:- Core Data
extension HomeViewModel {
    
    func getweathersFromCoreData() {

        managedObjectContext.rx.entities(WeatherInfoCoredataModel.self, sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]).asObservable()
            .subscribe(onNext: { [weak self] _categories in
                guard let `self` = self else {return}
                var weathers = [WeatherDetails]()
                for item in _categories {
                    let _item = WeatherDetails(weatherDetails: item)
                    weathers.append(_item)
                }
                self.weathersData.accept(weathers)
            }).disposed(by: disposeBag)
    }
}

//MARK:- API Call
extension HomeViewModel {

    func getCategoriesByLatLng(lat : String, lng : String) {

        dependencies.api.getForecastWeatherByLatLng(lat: lat, lng: lng)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let _):
                        self._getWeatherData.on(event)
                    case .failure(let error):
                        // Fetch data from local cache when internet is not available
                        if error.code == InternetConnectionErrorCode.offline.rawValue {
                            
                            self.alertDialog.onNext((NSLocalizedString("Network error", comment: ""), error.message))
                        } else {
                            self.alertDialog.onNext(("Error", error.message))
                        }
                    }
                    
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    func getCategoriesByCityId(cityId : Int) {

        dependencies.api.getForecastWeather(cityId: cityId)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let _):
                        self._getWeatherData.on(event)
                    case .failure(let error):
                        // Fetch data from local cache when internet is not available
                        if error.code == InternetConnectionErrorCode.offline.rawValue {
                            
                            self.alertDialog.onNext((NSLocalizedString("Network error", comment: ""), error.message))
                        } else {
                            self.alertDialog.onNext(("Error", error.message))
                        }
                    }
                    
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
}
