//
//  RegisterScreenViewController.swift
//  A&ELoginScreen
//
//  Created by James Hall on 2/21/17.
//  Copyright © 2017. All rights reserved.
//  Edited by Stephen Lomangino, James Hall and Yamnel Serra
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterScreenViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var reEnterPasswordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    var stateField = String()
    @IBOutlet weak var zipCodeField: UITextField!

    
    //String array holding all 50 states to be used as data source for pickerView
    var pickerDataSource = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware ", "Florida ", "Georgia ", "Hawaii ", "Idaho ", "Illinois ", "Indiana ", "Iowa ", "Kansas ", "Kentucky ", "Louisiana ", "Maine ", "Maryland ", "Massachusetts ", "Michigan ", "Minnesota ", "Mississippi ", "Missouri ", "Montana ", "Nebraska ", "Nevada ", "New Hampshire ", "New Jersey ", "New Mexico ", "New York ", "North Carolina ", "North Dakota ", "Ohio ", "Oklahoma ", "Oregon ", "Pennsylvania ", "Rhode Island ", "South Carolina ", "South Dakota ", "Tennessee ", "Texas ", "Utah ", "Vermont ", "Virginia ", "Washington ", "West Virginia ", "Wisconsin ", "Wyoming"]

    //Sets the name stored at the current pickerDataSource array index as the current row title
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return pickerDataSource[row]
    }
    
    //Stores the current selected row in the pickerView as a string named stateField, for later use
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        stateField = pickerDataSource[row]
    }

    //Returns the total number of components (not rows) in the picker view
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1

    }

    //Returns the number of rows in the pickerView, which is 
    //equal to the number of elements in pickerDataSource
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return pickerDataSource.count
    }

    //IB action to be perfomed when the user presses the "Register" button
    @IBAction func registerAction(_ sender: UIButton) {
        
        let fields = ["Email":emailField.text,"Password":passwordField.text, "Re-Enter Password":reEnterPasswordField.text, "First Name":firstNameField.text, "Last Name":lastNameField.text, "Street Address":streetAddressField.text, "City":cityField.text, "Zip Code":zipCodeField.text]
        
        var emptyFields = [String]()
        
        for (name,value) in fields{
            
            if (value == ""){
            
                emptyFields.append(name)
            
            }
        }
        
        if(emptyFields.count != 0){
                
            if(emptyFields.count > 0){
                    
                var eFieldList: String?
                    
                for element in emptyFields {
                    
                    if eFieldList == nil {
                        
                        eFieldList = element
                    } else {
                        
                        eFieldList = eFieldList! + ", " + element
                    }
                }
                    
                //Creates a UIAlertController which will display the error caught
                let blankFieldAlertController = UIAlertController(title: "Blank Fields!", message: "The following fields have been left blank: \n\n \(eFieldList!)", preferredStyle: UIAlertControllerStyle.alert)
                    
                //Specifies the text and behavior of the button attached to the UIAlertController
                blankFieldAlertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                    
                //Causes the controller to display on-screen with animation
                self.present(blankFieldAlertController, animated: true, completion: nil)
                    
                return
            }
        }
        
        //Guard statement checks to ensure that optional fields have values present
        //And then updates their respective labels with their stored values if they are
        guard let email = emailField.text, let password = passwordField.text, let reEnterPassword = reEnterPasswordField.text, let firstName = firstNameField.text, let lastName = lastNameField.text, let streetAddress = streetAddressField.text, let city = cityField.text, let zipCode = zipCodeField.text

                else {
                    
                    return
                }

        //If the two password input fields are equal, 
        //and the Terms & Conditions agreement switch is ON
        if ((reEnterPassword == password)) {

        //Attempts to create a new user in the DB with values stored from user input
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (FIRUser, error) in

            //If an error has been caught
            if (error != nil) {
                
                //Creates a UIAlertController which will display the error caught
                let registrationAlertController = UIAlertController(title: "Could Not Create Acount", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                
                //Specifies the text and behavior of the button attached to the UIAlertController
                registrationAlertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                
                //Causes the controller to display on-screen with animation
                self.present(registrationAlertController, animated: true, completion: nil)
                
                return
            }
            
            //Stores the created user's unique uid into a variable using the guard statement
            //which checks to ensure that the optional FIRUser?.uid field has a value present
            guard let uid = FIRUser?.uid else {
                return
            }

            //User was successfully created

            //Initializes reference to Firebase object
            let ref  : FIRDatabaseReference! = FIRDatabase.database().reference()
            
            //Creates a child object in the referenced database
            let userReference = ref.child("users")

            //values dictionary holds values to be updated into referenced database
            let values = ["email": email, "firstName": firstName,
                "lastName": lastName, "streetAddress": streetAddress, "city": city, "state": self.stateField, "zipCode": zipCode]

            //Adds an additional child which is set as the user's unique user id, and then updates
            //said child with values that have been stored in above-declared values dictionary
            userReference.child(uid).updateChildValues(values, withCompletionBlock: { (err, ref) in

                if err != nil {
            
                    print(err!)

                    return
                }
            })
        })

        //Once the user has been created, segue switches views to Email Login Screen
        self.performSegue(withIdentifier: "completed", sender: self)

        } else if reEnterPassword != password { //If both password fields are not equal

            //Creates a UIAlertController which will display the error
            let passwordAlertController = UIAlertController(title: "Password Mismatch", message:
                "Both password fields must match!", preferredStyle: UIAlertControllerStyle.alert)
            
            //Specifies the text and behavior of the button attached to the UIAlertController
            passwordAlertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))

            //Causes the controller to display on-screen with animation
            self.present(passwordAlertController, animated: true, completion: nil)

        }
//        }
    }

        override func viewDidLoad() {
            super.viewDidLoad()
            self.pickerView.dataSource = self;
            self.pickerView.delegate = self;

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
