//
//  NavBarViews.swift
//  Products
//
//  Created by Brian Doyle on 2/15/22.
//

import SwiftUI

struct NavBarLeadingView: View {
    @EnvironmentObject var viewModel: ProductsViewModel

    var body: some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gearshape")
        }
        .buttonStyle(.plain)
    }
}

struct NavBarTrailingView: View {
    enum Kind {
        case addRandomPokemon
        case cart
    }

    let kind: Kind

    @EnvironmentObject var viewModel: ProductsViewModel

    var body: some View {
        switch kind {
        case .addRandomPokemon:
            Button {
                addRandomPokemonToCart()
            } label: {
                Image(systemName: "questionmark.circle")
            }
        case .cart:
            NavigationLink(destination: CartView()) {
                ZStack {
                    Image(systemName: "cart")

                    let cartQuantity = viewModel.cartQuantity

                    if cartQuantity > 0 {
                        Text("\(cartQuantity)")
                            .font(.caption)
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .fill(.red)
                                    .frame(width: 16, height: 16)
                            )
                            .position(x: 26, y: 20)
                    }
                }
            }
            .buttonStyle(.plain)
        }
    }

    private func addRandomPokemonToCart() {
        let maxValue = viewModel.products.count - 1

        Fetcher.fetch("https://project13.us/cgi-bin/rng_service.py?minValue=0&maxValue=\(maxValue)") { result in
            DispatchQueue.main.async {
                if
                    case .success(let data) = result,
                    let index = Int(data.utf8.trimmingCharacters(in: .whitespacesAndNewlines))
                {
                    DispatchQueue.main.async {
                        guard let product = viewModel.products.element(at: index) else {
                            return
                        }
                        guard !viewModel.isProductInCart(product) else {
                            addRandomPokemonToCart()
                            return
                        }
                        viewModel.addToCart(product)
                    }
                }
            }
        }
    }
}
