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
//let API_KEY: String = "36d4d98adf2d4f627e3d4fdef04f5fbc0e38a263b3f08db6b3f249f7b36010fe"

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
var TOTAL_PAYMENT: String = "00.00"




let URL_STRING: String = "http://192.168.50.83:8080/api/v2/shopdb/_table/"
//let URL_STRING: String = "http://73.23.149.151:8080/api/v2/shopdb/_table/"


let USER_ID: String = "1989"

typealias DownloadComplete = (_ json: JSON?) -> (Void)
typealias LaborDownloadComplete = (_ json: JSON?) -> (Void)
