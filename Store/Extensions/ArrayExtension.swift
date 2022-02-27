//
//  ArrayExtension.swift
//  Products
//
//  Created by Brian Doyle on 2/27/22.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}
