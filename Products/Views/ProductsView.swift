//
//  ProductsView.swift
//  Products
//
//  Created by Brian Doyle on 2/15/22.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var viewModel: ProductsViewModel

    var items: [GridItem] {
        return Array(repeating: .init(.fixed(120)), count: 3)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: items) {
                ForEach(viewModel.products, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        VStack {
                            AsyncImage(url: product.imageURL)
                                .frame(width: 120, height: 120)

                            Text(product.name)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    @StateObject private static var viewModel = ProductsViewModel.testModel

    static var previews: some View {
        ProductsView()
            .environmentObject(viewModel)
    }
}
