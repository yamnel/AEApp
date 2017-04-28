//
//  Data.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 4/26/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UData {
    
    init(){
        
        LoginController.currentUser.getUserOrderPartsInfo { info in
            LoginController.currentUser.orderPartsInfoData = info
            
            print("The PartsInfo is \(LoginController.currentUser.orderPartsInfoData)") //TESTING\\
            
            let str = LoginController.currentUser.orderPartsInfoData.description
            //            print(str) // TESTING \\
            
            do{
                try str.write(toFile: LoginController.currentUser.orderPartsInfoPath, atomically: false, encoding: String.Encoding.utf8)
                print("\nwrote to Parts file\n")
            } catch{
                print("Could not write to file")
            }
            LoginController.currentUser.parseItems()
        }

    }
}
