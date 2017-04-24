//
//  UserInformation.swift
//  A&ELoginScreen
//
//  Created by Yamnel Serra on 4/21/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

//import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class UserInformation{
    var carInfoPath: String!
    var carInfoData: JSON!
    var carInfoFileName: String = "user_car_info"
    
//    var paymentDatesInfoPath: String!
    var paymentDatesInfoData: JSON!
    
    var paymentDatesInfoPath: String!// = "\(AppDelegate.getAppDelegate().getDocDir())/user_payment_info.json"
    
    var orderPartsInfoPath: String = "\(AppDelegate.getAppDelegate().getDocDir())/user_order_parts_info.json"
    var orderPartsInfoData: JSON!
    var orderPartsInfoFileName: String = "user_order_parts_info"
    
    var orderLaborInfoPath: String!
    var orderLaborInfoData: JSON!
    var orderLaborInfoFileName: String = "user_order_laborinfo"
    
    var listOfPaymentDates: [String] =  []
    
    // holds the items
    
    
    
    init(){
        
        
        
        // get the all te car's info
        self.carInfoPath =  "\(AppDelegate.getAppDelegate().getDocDir())/\(self.carInfoFileName).json"
        print(AppDelegate.getAppDelegate().getDocDir())
        self.getUserCarInfo{ info in
            self.carInfoData = info
            let str = self.carInfoData.description
            
            do{
                try str.write(toFile: self.carInfoPath, atomically: false, encoding: String.Encoding.utf8)
            } catch{
                print("Could not write to file")
            }
        }
        
        
        // get all the order dates
        self.paymentDatesInfoPath =  "\(AppDelegate.getAppDelegate().getDocDir())/user_payment_info.json"
        print(self.paymentDatesInfoPath)
        print(" ")
        print(" ")
        self.getUserOrderDateInfo{ info in
            self.paymentDatesInfoData = info
            print("The paymentInfo is \(self.paymentDatesInfoData)") //TESTING\\
            
            let str = self.paymentDatesInfoData.description
            print(str) // TESTING \\
            do{
                try str.write(toFile: self.paymentDatesInfoPath, atomically: false, encoding: String.Encoding.utf8)
            } catch{
                print("Could not write to file")
            }
        }
        
    }
    
    
    
    
    
    func parseOrderLabor() -> [String:String]{
        var ret: [String:String]!
        var description: [String] = []
        var cost:[String] = []
        
        var jsondict:Dictionary<String, AnyObject>!
        var jsonData: Data!
        do{
            let url = URL(fileURLWithPath: self.orderLaborInfoPath)
            jsonData = try Data(contentsOf: url)
            jsondict = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
            
            
        }catch{
            
        }
        
        
        //        print("TESTING  \(jsondict)") // TESTING \\
        let orderLaborList: Array<Dictionary<String, AnyObject>> = jsondict["resource"] as! Array<Dictionary<String, AnyObject>>
        
        for var info in orderLaborList{
            description.append(info["Description"]! as! String)
            cost.append(String(info["Sale"]! as! Int))
            
        }
        
        for var i in 0..<description.count{
            ret[description[i]] = cost[i]
        }
        
        return ret
    }
    
    
    
    func parsePaymentDates(){
        var jsondict: Dictionary<String, AnyObject>!
        var jsonData: Data!
        do{
            let url = URL(fileURLWithPath: self.paymentDatesInfoPath)
            jsonData = try Data(contentsOf: url)
            jsondict = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
            
        }catch{
            
        }
        
        let orderDateList: Array<Dictionary<String, AnyObject>> = jsondict["resource"] as! Array<Dictionary<String, AnyObject>>
        
        for var dateInfo in orderDateList{
            self.listOfPaymentDates.append(dateInfo["PaymentDate"]! as! String)
        }
        
    }

    
    func parseItems(){
        var jsondict: Dictionary<String, AnyObject>!
        var jsonData: Data!
        do{
            let url = URL(fileURLWithPath: self.orderPartsInfoPath)
            jsonData = try Data(contentsOf: url)
            jsondict = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
            
        }catch{
            
        }
        
        let orderpartsList: Array<Dictionary<String, AnyObject>> = jsondict["resource"] as! Array<Dictionary<String, AnyObject>>
        
        for var job in orderpartsList{
            let desc = job["Description"] as! String
            let cost = String(job["Cost"] as! Int)
            ITEM_LIST.append(["Description": desc, "Cost": cost])
        }

    }
    
    
    func getUserOrderLaborInfo(completed: @escaping LaborDownloadComplete){
        
        let url = URL(string: "\(URL_STRING)\(ORDER_LABOR_TABLE)?api_key=\(API_KEY)&filter=CustId=\(USER_ID)&filter=PaymentDate='\(CLEAN_PAYMENT_DATE)'")!
        Alamofire.request(url).validate().responseJSON { response in
            do{
                let json = JSON(data: response.data!)
                
                completed(json)
            }
        }
    }
    

    
    func getUserOrderPartsInfo(completed: @escaping DownloadComplete ){
        
        let userGeneralInfoURL = URL(string: "\(URL_STRING)\(ORDER_PARTS_TABLE)?api_key=\(API_KEY)&filter=CustId=\(USER_ID)&filter=PaymentDate='\(CLEAN_PAYMENT_DATE)'")!
        Alamofire.request(userGeneralInfoURL).validate().responseJSON { response in
            do{
                let json = JSON(data: response.data!)
                
                completed(json)
            }
        }
    }

    
    
    func getUserOrderDateInfo(completed: @escaping DownloadComplete){
        let userGeneralInfoURL = URL(string: "\(URL_STRING)\(PAYMENT_DATES_TABLE)?api_key=\(API_KEY)&filter=CustomerId=\(USER_ID)")!
        Alamofire.request(userGeneralInfoURL).validate().responseJSON { response in
            do{
                let json = JSON(data: response.data!)
                
                completed(json)
            }
        }
    }
    
    
    func getUserCarInfo(completed: @escaping DownloadComplete){
        let userGeneralInfoURL = URL(string: "\(URL_STRING)\(VEHICLE_TABLE)?api_key=\(API_KEY)&filter=CustId=\(USER_ID)")!
        Alamofire.request(userGeneralInfoURL).validate().responseJSON { response in
            do{
                let json = JSON(data: response.data!)
                
                completed(json)
            }
        }
    }
    
    
    
    
}
