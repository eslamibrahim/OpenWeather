//  task
//
//  Created by islam on 9/23/20.
//


import Foundation
import UIKit

enum InternetConnectionErrorCode: Int {
    case offline = 10101
}

//MARK:- Global Variables
let Application  = UIApplication.shared.delegate as! AppDelegate

//MARK:- UIDevice Static Constants

let Screen                  = UIScreen.main.bounds.size
let apiKey = "=b6113256d886a3ddbcd82ddce870495b"

let hasBeenLaunchedBeforeFlag = "HasBeenLaunchedBeforeFlag"
let firstApiCallFlag = "FirstApiCallFlag"


