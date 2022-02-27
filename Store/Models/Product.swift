//
//  Product.swift
//  Products
//
//  Created by Brian Doyle on 2/15/22.
//

import Foundation
import UIKit
import System

struct Product: Codable, Hashable, Identifiable {
    let description: String
    let id: String
    let imageURL: URL
    let name: String
    let price: Decimal

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let string = try container.decode(String.self, forKey: .imageURL)
        guard let url = URL(string: string) else {
            let context = DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "cannot create url from '\(string)'")

            throw DecodingError.dataCorrupted(context)
        }

        description = try container.decode(String.self, forKey: .description)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        imageURL = url
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Decimal.self, forKey: .price)
    }

    static func loadProducts(_ completion: @escaping (Result<[Product], Error>) -> Void) {
        struct ProductsWrapper: Codable {
            let products: [Product]

            enum CodingKeys: String, CodingKey {
                case products = "pokemon"    // swap this out after I get some products
            }
        }

        Fetcher.fetch(
            "https://project13.us/cgi-bin/cs361.py?imageSet=pokemon",
            into: ProductsWrapper.self,
            completion: { r in
                let result: Result<[Product], Error>

                switch r {
                case .failure(let error):
                    result = .failure(error)
                case .success(let wrapper):
                    result = .success(wrapper.products)
                }

                completion(result)
            }
        )
    }
}

extension Product {
    private init(imageURL: String, name: String) {
        self.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        self.id = UUID().uuidString
        self.imageURL = URL(string: imageURL)!
        self.name = name
        self.price = 9.99
    }

    static let testProducts: [Product] = [
        Product(imageURL: "https://project13.us/images/cs361/zangoose.png", name: "Zangoose"),
        Product(imageURL: "https://project13.us/images/cs361/zapdos.png", name: "Zapdos"),
        Product(imageURL: "https://project13.us/images/cs361/zebstrika.png", name: "Zebstrika")
    ]
}
