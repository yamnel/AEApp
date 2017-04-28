

import UIKit
import MessageUI

class PreviewViewController: UIViewController {

    @IBOutlet weak var webPreview: UIWebView!
    
    var invoiceInfo: [String: AnyObject]!
    
    //testing\\
    
    
    
    
    //testing\\
    
    
    
    var invGenerator: InvoiceGenerator!
    
    var invoiceContent: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let pdfPath = (self.getDirectoryPath() as NSString).appendingPathComponent("Invoice \(SELECTED_PAYMENT_DATE).pdf")
        
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
    
    func createInvoice() {
        
        LoginController.currentUser.parseItems()
        
        invGenerator = InvoiceGenerator()

        if let invoiceHTML = invGenerator.renderInvoice(invoiceNumber: SELECTED_PAYMENT_DATE,
                                                           invoiceDate: SELECTED_PAYMENT_DATE,
                                                           recipientInfo: "",
                                                           items: ITEM_LIST ,
                                                           totalAmount: TOTAL_PAYMENT) {
            
            webPreview.loadHTMLString(invoiceHTML, baseURL: NSURL(string: invGenerator.invoiceTemplatePath!)! as URL)

            invoiceContent = invoiceHTML
        }
    }
}
