//
//  NavigationDelegate.swift
//  WebviewApp
//
//  Created by mac on 5/21/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation
import WebKit

class NavigationDelegate: NSObject, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if let url = webView.url?.absoluteString,
            API.Products.isProductPage(url) {
            webView.evaluateJavaScript(ScriptInjector.Product.detailPage, completionHandler: nil)
            
            print("we are on the product page")
        }
    }
}
