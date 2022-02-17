//
//  SequenceExtension.swift
//  Products
//
//  Created by Brian Doyle on 2/16/22.
//

import Foundation

extension Sequence {
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        areInIncreasingOrder closure: ((T, T) throws -> Bool)? = nil)
        rethrows -> [Element]
    {
        let closure = closure ?? { $0 < $1 }

        return try sorted {
            try closure($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
}
