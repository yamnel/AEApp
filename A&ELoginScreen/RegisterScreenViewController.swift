//
//  RegisterScreenViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 2/21/17.
//  Copyright © 2017 Yamnel. All rights reserved.
//

import UIKit



class RegisterScreenViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
   
    @IBOutlet weak var registerScrollView: UIScrollView!
    
    
    
    @IBOutlet var pickerView: UIPickerView!
    
    var pickerDataSource = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware ", "Florida ", "Georgia ", "Hawaii ", "Idaho ", "Illinois ", "Indiana ", "Iowa ", "Kansas ", "Kentucky ", "Louisiana ", "Maine ", "Maryland ", "Massachusetts ", "Michigan ", "Minnesota ", "Mississippi ", "Missouri ", "Montana ", "Nebraska ", "Nevada ", "New Hampshire ", "New Jersey ", "New Mexico ", "New York ", "North Carolina ", "North Dakota ", "Ohio ", "Oklahoma ", "Oregon ", "Pennsylvania ", "Rhode Island ", "South Carolina ", "South Dakota ", "Tennessee ", "Texas ", "Utah ", "Vermont ", "Virginia ", "Washington ", "West Virginia ", "Wisconsin ", "Wyoming"]
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
         return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
    
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return pickerDataSource.count
    }
    
    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            registerScrollView.contentInset = UIEdgeInsets.zero
        } else {
            registerScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        registerScrollView.scrollIndicatorInsets = registerScrollView.contentInset
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Cancel Landscape Orientation 
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

}
