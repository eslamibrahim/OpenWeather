//
//  ViewController.swift
//  WeatherAppMVC
//
//  Created by OSX on 9/9/19.
//  Copyright © 2019 eslam. All rights reserved.
//

import UIKit
import CoreLocation
import PopupDialog

class HomeViewController: BaseViewController {
    
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var viewModel : HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadAllCities {[weak self] (res) in
            self?.dropDownSetUP(cities: res!)
        }
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }
    
    func setupUI() {
        
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        if  UserDefaults.isFirstLaunch() {
            self.setupLocation()
        }
        setupTableView()
    }
    
    func setupTableView() {
        
        self.viewModel.TableData.asObservable()
                  .bind(to: tableView.rx.items) { (table, row, element) in
                      let indexPath = IndexPath(row: row, section: 0)
                    let cell = table.dequeueReusableCell(withIdentifier: "HomeTableViewCell" , for: indexPath) as! HomeTableViewCell
                    cell.configurationCell(weatherIcon: element.weatherInfo?[0].iconUrlPath, city: element.city!)
                    cell.selectionStyle = .none
                    cell.deleteItemButton.rx.tap.bind{ [weak self] _ in
                        guard let self = self else {return}
                        _ = try? self.viewModel.managedObjectContext.rx.delete(WeatherInfoCoredataModel(weatherDetails: element))
                    }.disposed(by: cell.disposeBagCell)
                    cell.updateItemButton.rx.tap.bind{ [weak self] _ in
                        guard let self = self else {return}
                        self.viewModel.getCategoriesByCityId(cityId: element.city?.id ?? 0)
                    }.disposed(by: cell.disposeBagCell)
                      return cell
                  }
                  .disposed(by: disposeBag)
        tableView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] index in
            self?.viewModel.selectWeathersData.onNext((data : (self?.viewModel.weathersData.value[index.row])!, count : (self?.viewModel.weathersData.value.count) ?? 0))
        } ).disposed(by: disposeBag)
        

    }
    
    func dropDownSetUP( cities : [CityModel])  {
        
        let dropDownTop = VPAutoComplete()
        let citiesName = cities.map { $0.name ?? ""}
        dropDownTop.dataSource = citiesName 
        dropDownTop.onTextField = cityTextField
        dropDownTop.onView = self.view
        dropDownTop.didEndText(textField: cityTextField)
        //        dropDownTop.showAlwaysOnTop = true //To show dropdown always on top.
        dropDownTop.show { (str, index) in
            print("string : \(str) and Index : \(index)")
            self.cityTextField.text = str
            self.viewModel.getCategoriesByCityId(cityId: cities[index].id ?? 0)
        }
    }
    
    func  setupLocation() {
        viewModel.locationManager.getLocation {[weak self] response in
            switch response {
            case .denied:
                self?.viewModel.getCategoriesByCityId(cityId: 5056033)
            case .location(let location):
                let  lat = String(location.latitude)
                let  lng = String(location.longitude)
                self?.viewModel.getCategoriesByLatLng(lat: lat, lng: lng)
            }
         }
    }
    
}
    
