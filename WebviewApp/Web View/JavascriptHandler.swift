//
//  JavascriptHandler.swift
//  WebviewApp
//
//  Created by mac on 5/21/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation
import WebKit

protocol JavascriptHandler: WKScriptMessageHandler {
    
    var identifier: String { get }
}

protocol JavascriptHandlerDelegate: class {
    
    func received(product: Product)
}

class ScriptMessageHandler: NSObject, JavascriptHandler {
    
    var identifier = "ScriptMessageHandler"
    
    weak var delegate: JavascriptHandlerDelegate?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        do {
            // - convert javascript message to JSON
            let data = try JSONSerialization.data(withJSONObject: message.body, options: .sortedKeys)
            // - decode JSON object to custom object (Product)
            let product = try JSONDecoder().decode(Product.self, from: data)
            
            // - pass on product to delegate
            delegate?.received(product: product)
        }catch {
            print(error.localizedDescription)
        }
    }
}

