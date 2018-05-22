//
//  String+Regex.swift
//  WebviewApp
//
//  Created by mac on 5/21/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import Foundation

extension String {
    
    func matches(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "self MATCHES [c] %@", regex)
        let result = predicate.evaluate(with: self)
        return result
    }
}
