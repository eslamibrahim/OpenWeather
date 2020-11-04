//
//  WeatherViewController.swift
//  WeatherAppMVC
//
//  Created by OSX on 9/11/19.
//  Copyright © 2019 eslam. All rights reserved.
//

import UIKit

class WeatherViewController: BaseViewController {
    
    var viewModel : WeatherDetailsViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    var refreshCompletion : (() -> ())?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        
        self.viewModel.TableData.asObservable()
                  .bind(to: tableView.rx.items) ({ (table, row, element) in
                      let indexPath = IndexPath(row: row, section: 0)
                    let cell = table.dequeueReusableCell(withIdentifier: "WeatherTableViewCell" , for: indexPath) as! WeatherTableViewCell
                    cell.configurationCell(city: self.viewModel.data.city!.name ?? "", weather : element)
                    cell.selectionStyle = .none
                      return cell
                  })
                  .disposed(by: disposeBag)

    }
    
    @IBAction func addAction(_ sender: Any) {
        _ = try? self.viewModel.managedObjectContext.rx.update(WeatherInfoCoredataModel(weatherDetails: self.viewModel.data))
    }
}
