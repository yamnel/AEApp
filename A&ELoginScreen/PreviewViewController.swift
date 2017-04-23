

import UIKit
import MessageUI

class PreviewViewController: UIViewController {

    @IBOutlet weak var webPreview: UIWebView!
    
    var invoiceInfo: [String: AnyObject] = [:]
    
    //testing\\
    
    
    
    
    //testing\\
    
    
    
    var invGenerator: InvoiceGenerator!
    
    var invoiceContent: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // TESTING \\
        
        
        LoginController.currentUser.orderLaborInfoPath = "\(AppDelegate.getAppDelegate().getDocDir())/\(LoginController.currentUser.orderLaborInfoFileName).json"
        //        print(LoginController.currentUser.orderLaborInfoPath)
        
        LoginController.currentUser.getUserOrderLaborInfo { info in
            LoginController.currentUser.orderLaborInfoData = info
            print("The paymentInfo is \(LoginController.currentUser.orderLaborInfoData)") //TESTING\\
            
            let str = LoginController.currentUser.orderLaborInfoData.description
            //            print(str) // TESTING \\
            
            do{
                try str.write(toFile: LoginController.currentUser.orderLaborInfoPath, atomically: false, encoding: String.Encoding.utf8)
                
            } catch{
                print("Could not write to file")
            }
        }
        
        // TESTING \\
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        createInvoice()
    }
    

    // MARK: IBAction Methods
    
    
    /*
     * When the share button is tapped, this method:
     *  exports the invoice to the app's Documents folder as PDF, 
     *  and then opens a UIActivityViewController
     *  which will allow the PDF to be shared using whichever apps can do so
     */
    @IBAction func share(_ sender: Any) {
        
        invGenerator.exportToPDF(HTMLContent: invoiceContent)
        
        let fileManager = FileManager.default
        
        let pdfPath = (self.getDirectoryPath() as NSString).appendingPathComponent("Invoice \(invoiceInfo["invoiceNumber"] as! String).pdf")
        
        if fileManager.fileExists(atPath: pdfPath){

            let pDF = NSData(contentsOfFile: pdfPath)!

            let activityViewController: UIActivityViewController =
                    UIActivityViewController(activityItems: [pDF], applicationActivities: nil)

            activityViewController.popoverPresentationController?.sourceView=self.view

            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("Unable to locate document!")
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
//    func createInvoice() {
//        
//        invGenerator = InvoiceGenerator()
//        
//        if let invoiceHTML = invGenerator.renderInvoice(invoiceNumber: invoiceInfo["invoiceNumber"] as! String,
//                                                        invoiceDate: invoiceInfo["invoiceDate"] as! String,
//                                                        recipientInfo: invoiceInfo["recipientInfo"] as! String,
//                                                        items: invoiceInfo["items"] as! [[String: String]],
//                                                        totalAmount: invoiceInfo["totalAmount"] as! String) {
//            
//            webPreview.loadHTMLString(invoiceHTML, baseURL: NSURL(string: invGenerator.invoiceTemplatePath!)! as URL)
//            
//            invoiceContent = invoiceHTML
//        }
//    }
    
    func createInvoice() {

        invGenerator = InvoiceGenerator()

        if let invoiceHTML = invGenerator.renderInvoice(invoiceNumber: SELECTED_PAYMENT_DATE,
                                                           invoiceDate: SELECTED_PAYMENT_DATE,
                                                           recipientInfo: "",
                                                           items: invoiceInfo["items"] as! [[String : String]],
                                                           totalAmount: "1000") {
            
            webPreview.loadHTMLString(invoiceHTML, baseURL: NSURL(string: invGenerator.invoiceTemplatePath!)! as URL)

            invoiceContent = invoiceHTML
        }
    }
}
