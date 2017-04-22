//
//  UserInformation.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 4/21/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserInformation{
    
    
    
    
    
    func getUserCarInfo(completed: @escaping CarNameDownloadComplete){
        let userGeneralInfoURL = URL(string: "\(URL_STRING)\(VEHICLE_TABLE)?api_key=\(API_KEY)&filter=CustId=\(USER_ID)")!
        Alamofire.request(userGeneralInfoURL).validate().responseJSON { response in
            do{
                let json = JSON(data: response.data!)
                
                completed(json)
            }
        }
    }
}
