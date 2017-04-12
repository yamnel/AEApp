//
//  InvoiceGenerator.swift
//
//  Created by James Hall on 4/3/17.
//

import UIKit

class InvoiceGenerator: NSObject {

    let invoiceTemplatePath = Bundle.main.path(forResource: "invoice", ofType: "html")
    
    let singleItemTemplatePath = Bundle.main.path(forResource: "single_item", ofType: "html")
    
    let lastItemTemplatePath = Bundle.main.path(forResource: "last_item", ofType: "html")
    
    let senderInfo = "A &amp E Auto Repair<br>1464 Market Circle<br>Port Charlotte, FL 33955<br>Phone: 941-627-3111"
    
    let dueDate = ""
    
    let paymentMethod = "Wire Transfer"
    
    let logoImageURL = "http://aandeautorepair.com/wp-content/uploads/2015/08/AE.png"
    
    var invoiceNumber: String!
    
    var pdfDirectory: String!
    
    override init() {
        super.init()
    }
    
    func renderInvoice(invoiceNumber: String, invoiceDate: String,
                       recipientInfo: String, items: [[String: String]],
                       totalAmount: String) -> String! {
        
        // Store the invoice number for future use.
        self.invoiceNumber = invoiceNumber
        
        do {
            // Load the invoice HTML template code into a String variable.
            var templateContent = try String(contentsOfFile: invoiceTemplatePath!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            templateContent = templateContent.replacingOccurrences(of:"#LOGO_IMAGE#", with: logoImageURL)
            
            // Invoice number.
            templateContent = templateContent.replacingOccurrences(of:"#INVOICE_NUMBER#", with: invoiceNumber)
            
            // Invoice date.
            templateContent = templateContent.replacingOccurrences(of:"#INVOICE_DATE#", with: invoiceDate)
            
            // Due date (we leave it blank by default).
            templateContent = templateContent.replacingOccurrences(of:"#DUE_DATE#", with: dueDate)
            
            // Sender info.
            templateContent = templateContent.replacingOccurrences(of:"#SENDER_INFO#", with: senderInfo)
            
            // Recipient info.
            templateContent = templateContent.replacingOccurrences(of: "#RECIPIENT_INFO#", with: recipientInfo.replacingOccurrences(of:"\n", with: "<br>"))
            
            // Payment method.
            templateContent = templateContent.replacingOccurrences(of:"#PAYMENT_METHOD#", with: paymentMethod)
            
            // Total amount.
            templateContent = templateContent.replacingOccurrences(of:"#TOTAL_AMOUNT#", with: totalAmount)
            
            
            // The invoice items will be added by using a loop.
            var allItems = ""
            
            // For all the items except for the last one we'll use the "single_item.html" template.
            // For the last one we'll use the "last_item.html" template.
            for i in 0..<items.count {
                var itemHTMLContent: String!
                
                // Determine the proper template file.
                if i != items.count - 1 {
                    itemHTMLContent = try String(contentsOfFile: singleItemTemplatePath!)
                }
                else {
                    itemHTMLContent = try String(contentsOfFile: lastItemTemplatePath!)
                }
                
                // Replace the description and price placeholders with the actual values.
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#ITEM_DESC#", with: items[i]["item"]!)
                
                // Format each item's price as a currency value.
                let formattedPrice = AppDelegate.getAppDelegate().getStringValueFormattedAsCurrency(items[i]["price"]!)
                itemHTMLContent = itemHTMLContent.replacingOccurrences(of: "#PRICE#", with: formattedPrice)
                
                // Add the item's HTML code to the general items string.
                allItems += itemHTMLContent
            }
            
            // Set the items.
            templateContent = templateContent.replacingOccurrences(of:"#ITEMS#", with: allItems)
            
            // The HTML code is ready.
            return templateContent
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
    func exportToPDF(HTMLContent: String) {
        
        
        let printPageRenderer = PrintRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)

        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let newPDF = drawPDF(printPageRenderer: printPageRenderer)
        
        //Hard-coded file name for testing purposes
//        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Invoice.pdf"
        
        pdfDirectory = "\(AppDelegate.getAppDelegate().getDocDir())/Invoice \(invoiceNumber!).pdf"
        newPDF?.write(toFile: pdfDirectory, atomically: true)
        
        print(pdfDirectory)
    }
    
    
    func drawPDF(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        
        UIGraphicsBeginPDFPage()
        
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    
    
}
