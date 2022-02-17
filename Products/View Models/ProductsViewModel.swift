//
//  ProductsViewModel.swift
//  Products
//
//  Created by Brian Doyle on 2/13/22.
//

import Foundation

final class ProductsViewModel: ObservableObject {
    struct CartItem: Hashable {
        let product: Product
        let quantity: Int
    }

    @Published var cart = [Product: Int]()
    @Published var isUserOver21 = false
    @Published var isUserAPokemonFan = false
    @Published var products = [Product]()

    var cartItems: [CartItem] { cart.map { .init(product: $0, quantity: $1) }.sorted(by: \.product.name) }
    var cartQuantity: Int { cart.values.reduce(0, +) }

    init(products: [Product]? = nil) {
        guard products == nil else {
            self.products = products!
            return
        }

        Product.loadProducts { result in
            if case .success(let products) = result {
                DispatchQueue.main.async { [weak self] in
                    self?.products = products
                }
            }
        }
    }

    func addToCart(_ product: Product) {
        cart[product] = (cart[product] ?? 0) + 1
    }

    func clearCart() {
        cart = [:]
    }

    func isProductInCart(_ product: Product) -> Bool {
        return cart.keys.contains(product)
    }

    func removeFromCart(_ product: Product) {
        guard let quantity = cart[product] else { return }
        guard quantity > 1 else {
            cart[product] = nil
            return
        }

        cart[product] = quantity - 1
    }
}

// MARK: -

extension ProductsViewModel {
    static var testModel: ProductsViewModel {
        return ProductsViewModel(products: Product.testProducts)
    }
}
