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
            Image(systemName: "questionmark.circle")
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
}
