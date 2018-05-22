//
//  ProductWebView.swift
//  WebviewApp
//
//  Created by mac on 5/21/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit
import WebKit

class ProductWebView: WKWebView {
    
    func configure(nav: WKNavigationDelegate, script: JavascriptHandler, homeURL: String){
    
        // set navigation delegate (i.e., actions performed when clicking a link)
        navigationDelegate = nav
        
        // set script handler (i.e., actions perform on button taps, etc)
        configuration.userContentController.add(script, name: script.identifier)

        // load the home page
        if let url = URL(string: homeURL) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
