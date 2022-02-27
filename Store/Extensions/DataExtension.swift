//
//  DataExtension.swift
//  Products
//
//  Created by Brian Doyle on 2/27/22.
//

import Foundation

extension Data {
    var utf8: String { return String(data: self, encoding: .utf8) ?? "" }
}
