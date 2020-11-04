//
//  task
//
//  Created by islam on 9/23/20.
//


import Foundation
import UIKit

extension String {
    
    // Tested against ["ab_dsfdsac_dsd_f", nil, "_", "__abc_a", "Ac_C", "abc", "abc_", "_abc", "", "Abc_def_De", "ABc_def_De", "ABC_def_De", "bc_def_De", "ADay", "aDay", "a_Day", "A_Day"]
    
    /// Underscore string to lowerCamelCase.
    var underscoreToCamelCase: String {
        
        let underscore = CharacterSet(charactersIn: "_")
        var items: [String] = self.components(separatedBy: underscore)
        
        var start: String = items.first ?? ""
        let first = String(start.prefix(1)).lowercased()
        let other = String(start.dropFirst())
        start =  first + other
        
        items.remove(at: 0)
        
        let camelCased: String =  items.reduce(start) { (result, i) -> String in
            result + i.capitalized
        }
        
        return camelCased
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}

extension String {
    
    func lineSpaced(_ spacing: CGFloat,alignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedString
    }
    
    func lineSpaceWithFont(_ spacing: CGFloat, font:UIFont, fontColour: UIColor, alignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                             NSAttributedString.Key.font: font,
                                                                             NSAttributedString.Key.foregroundColor: fontColour
            ])
        return attributedString
    }
    
        func getFormattedDate() -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formateDate = dateFormatter.date(from: self)!
            dateFormatter.dateFormat = "MMM d, h:mm a"
            return dateFormatter.string(from: formateDate)
        }


}

extension Double {
    
     func temperatureConvertorKelvinToCelsius() -> String {
        return String( Int (self - 273.15)) + "°C"
    }
}
