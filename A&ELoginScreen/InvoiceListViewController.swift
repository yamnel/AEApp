

import UIKit
import SwiftyJSON
import Alamofire

class InvoiceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblInvoices: UITableView!
    
    
    var invoices: [[String: AnyObject]]!
    
    var selectedInvoiceIndex: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblInvoices.delegate = self
        tblInvoices.dataSource = self
        
        // TESTING \\
        LoginController.currentUser.parsePaymentDates()
        print(LoginController.currentUser.listOfPaymentDates)
        
        // TESTING \\
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let inv = UserDefaults.standard.object(forKey: "invoices") {
            invoices = inv as? [[String: AnyObject]]
            tblInvoices.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "idSeguePresentPreview" {
                let previewViewController = segue.destination as! PreviewViewController
//                previewViewController.invoiceInfo["items"] = ITEM_LIST as? AnyObject
            }
        }
    }
    

    @IBAction func back(_ sender: Any) {
        
        //dismiss your viewController
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: IBAction Methods
    
    @IBAction func createInvoice(_ sender: AnyObject) {
        let creatorViewController = storyboard?.instantiateViewController(withIdentifier: "idCreateInvoice") as! CreatorViewController
        creatorViewController.presentCreatorViewControllerInViewController(self) { (invoiceNumber, recipientInfo, totalAmount, items) in
            DispatchQueue.main.async(execute: { 
                if self.invoices == nil {
                    self.invoices = [[String: AnyObject]]()
                }
                
                // Add the new invoice data to the invoices array.
                self.invoices.append(["invoiceNumber": invoiceNumber as AnyObject, "invoiceDate": self.formatAndGetCurrentDate() as AnyObject, "recipientInfo": recipientInfo as AnyObject, "totalAmount": totalAmount as AnyObject, "items": items as AnyObject])
                
                // Update the user defaults with the new invoice.
                UserDefaults.standard.set(self.invoices, forKey: "invoices")
                
                // Reload the tableview.
                self.tblInvoices.reloadData()
            })
        }
    }
    
    
    // MARK: Custom Methods
    
    func formatAndGetCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        return dateFormatter.string(from: Date())
    }
    
    
    // MARK: UITableView Delegate and Datasource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return LoginController.currentUser.listOfPaymentDates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "invoiceCell", for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "invoiceCell")
        }
        
        cell.textLabel?.text = LoginController.currentUser.listOfPaymentDates[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SELECTED_PAYMENT_DATE = LoginController.currentUser.listOfPaymentDates[indexPath.row]
        //print(SELECTED_PAYMENT_DATE)
        
        // TESTING \\
        
        
//        LoginController.currentUser.orderLaborInfoPath = "\(AppDelegate.getAppDelegate().getDocDir())/\(LoginController.currentUser.orderLaborInfoFileName).json"
//        //        print(LoginController.currentUser.orderLaborInfoPath)
//        
//        LoginController.currentUser.getUserOrderLaborInfo { info in
//            LoginController.currentUser.orderLaborInfoData = info
//            
//            print("The LaborInfo is \(LoginController.currentUser.orderLaborInfoData)") //TESTING\\
//            
//            let str = LoginController.currentUser.orderLaborInfoData.description
//            //            print(str) // TESTING \\
//            
//            do{
//                try str.write(toFile: LoginController.currentUser.orderLaborInfoPath, atomically: false, encoding: String.Encoding.utf8)
//                
//            } catch{
//                print("Could not write to file")
//            }
//        }
        
        var x = UData()
        
//        LoginController.currentUser.orderPartsInfoPath = "\(AppDelegate.getAppDelegate().getDocDir())/\(LoginController.currentUser.orderPartsInfoFileName).json"
        
//        LoginController.currentUser.getUserOrderPartsInfo { info in
//            LoginController.currentUser.orderPartsInfoData = info
//            
//            print("The PartsInfo is \(LoginController.currentUser.orderPartsInfoData)") //TESTING\\
//            
//            let str = LoginController.currentUser.orderPartsInfoData.description
//            //            print(str) // TESTING \\
//            
//            do{
//                try str.write(toFile: LoginController.currentUser.orderPartsInfoPath, atomically: false, encoding: String.Encoding.utf8)
//                print("\nwrote to Parts file\n")
//            } catch{
//                print("Could not write to file")
//            }
//            LoginController.currentUser.parseItems()
//        }
        
        // TESTING \\

//        do{
////            try LoginController.currentUser.parseItems()
//        }catch{
//            print("NOPE!")
//        }
        
        selectedInvoiceIndex = (indexPath as NSIndexPath).row
        performSegue(withIdentifier: "idSeguePresentPreview", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            invoices.remove(at: (indexPath as NSIndexPath).row)
            tblInvoices.reloadData()
            UserDefaults.standard.set(self.invoices, forKey: "invoices")
        }
    }
    
    
}
