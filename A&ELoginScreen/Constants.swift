//
//  Constants.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 4/21/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import Foundation
import SwiftyJSON

let API_KEY: String = "065dce537ae7be843043e8938b77dfc27f48cfe9bd3fc3daa0769065e70f7ef0"

let CUSTOMER_TABLE = "SM.Customer"
let VEHICLE_TABLE = "vappvehicles"

let PAYMENT_DATES_TABLE = "vapppayments"
let ORDER_LABOR_TABLE = "vapplabor"
let ORDER_PARTS_TABLE = "vappparts"

var SELECTED_PAYMENT_DATE: String!


var CLEAN_PAYMENT_DATE: String{
    return SELECTED_PAYMENT_DATE.replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: ":", with: "%3A")
}

var ITEM_LIST =  [[String:String]]()
var TOTAL_PAYMENT: String!




let URL_STRING: String = "http://localhost:8080/api/v2/shopdb/_table/"

let USER_ID: String = "1989"

typealias DownloadComplete = (_ json: JSON?) -> (Void)
typealias LaborDownloadComplete = (_ json: JSON?) -> (Void)
