//
//  HomeTableViewCell.swift
//  task
//
//  Created by islam on 11/4/20.
//

import UIKit
import RxSwift
import RxCocoa


class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteItemButton: UIButton!
    @IBOutlet weak var updateItemButton: UIButton!

    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var cityCode: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    var disposeBagCell:DisposeBag = DisposeBag()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
         disposeBagCell = DisposeBag()
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurationCell(weatherIcon:String? , city : CityModel)  {
        
        if let _url = weatherIcon {
            let url = URL(string: _url)
            self.weatherIcon.downloadImageWithCaching(with: url?.absoluteString ?? "", placeholderImage: UIImage(named: "Placeholder"))
        }
        cityName.text = city.name
        cityCode.text = city.country_code
    }

}
