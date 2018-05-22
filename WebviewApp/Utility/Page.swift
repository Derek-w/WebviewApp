//
//  Page.swift
//  WebviewApp
//
//  Created by mac on 5/21/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation


struct Page {
    
    // contains all of the HTML content of the Order Page
    static var order: String? {
        return getContents(of: "YourOrder")
    }
    
    static func getContents(of filename: String) -> String? {
        guard let path = getPath(filename: filename) else { return nil }
        
        do {
            return try String(contentsOfFile: path)
        }catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func getPath(filename: String) -> String? {
        return Bundle.main.path(forResource: filename, ofType: "html")
    }
}

