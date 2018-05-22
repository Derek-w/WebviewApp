//
//  ViewController.swift
//  WebviewApp
//
//  Created by mac on 5/21/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: ProductWebView!
    
    let navigationDelegate = NavigationDelegate()
    let scriptHandler = ScriptMessageHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scriptHandler.delegate = self
        webView.configure(nav: navigationDelegate, script: scriptHandler, homeURL: API.Products.home)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: JavascriptHandlerDelegate {
    
    func received(product: Product) {
        
        let alertController = UIAlertController(
            title: "Enter Payment Information",
            message: "Credit Card Number",
            preferredStyle: .alert)
        
        let cancel = UIAlertAction(
            title: "Cancel",
            style: .default,
            handler: nil)
        
        alertController.addTextField(configurationHandler: nil)
        
        let purchase = UIAlertAction(
            title: "Purchase",
            style: .default, handler: { [weak alertController] (_)in
                let textField = alertController?.textFields![0]
                let text = textField?.text ?? ""
                if self.cardInfoValidation(cardInfo: text){
                    self.completePurchase(with: product)
                } else {
                    alertController?.message = "Invalid CardInfo!"
                    self.present(alertController!, animated: true, completion: nil)
                }
        })
        
        alertController.addAction(purchase)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func cardInfoValidation(cardInfo: String) ->Bool{
        return cardInfo.count == 16
    }
    
    func completePurchase(with product: Product){
        
        guard let orderPage = Page.order else { return }
        
        webView.loadHTMLString(orderPage
                .replacingOccurrences(of: "{name}", with: product.name)
                .replacingOccurrences(of: "{price}", with: product.price)
                .replacingOccurrences(of: "{image}", with: product.image),
                               baseURL: nil)
    }
}
