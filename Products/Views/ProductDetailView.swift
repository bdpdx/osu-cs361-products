//
//  ProductDetailView.swift
//  Products
//
//  Created by Brian Doyle on 2/15/22.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var viewModel: ProductsViewModel

    let product: Product

    var body: some View {
        let isProductInCart = viewModel.isProductInCart(product)

        VStack {
            AsyncImage(url: product.imageURL)
            Text(product.name)
                .font(.largeTitle)
            Text("$" + product.price.description)
                .font(.title)
            Spacer()
                .frame(height: 8)
            Text(product.description)
                .font(.caption)
                .padding()
            Spacer()
                .frame(height: 20)
            Button {
                viewModel.addToCart(product)
            } label: {
                Text(isProductInCart ? "Added!" : "Add To Cart")
                    .frame(width: 300, height: 60)
                    .font(.title2)
                    .background(.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(30)

            }
            .disabled(isProductInCart)
            .opacity(isProductInCart ? 0.5 : 1)
            // future work:
//            NavigationLink(destination: FindStoresView()) {
//                Text("Find Stores")
//                    .frame(width: 300, height: 60)
//                    .font(.title2)
//                    .background(.yellow)
//                    .foregroundColor(.black)
//                    .cornerRadius(30)
//            }
        }
        .navigationBarTitle(Text("Product"), displayMode: .inline)
        .navigationBarItems(leading: NavBarLeadingView())
        .navigationBarItems(trailing: NavBarTrailingView(kind: .cart))
   }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.testProducts[0])
    }
}
