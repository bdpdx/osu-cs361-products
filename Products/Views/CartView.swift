//
//  CartView.swift
//  Products
//
//  Created by Brian Doyle on 2/15/22.
//

import SwiftUI

fileprivate struct ProductRow : View {
    @EnvironmentObject var viewModel: ProductsViewModel

    let cartItem: ProductsViewModel.CartItem

    var body: some View {
        let product = cartItem.product

        HStack {
            AsyncImage(url: product.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .padding()

            VStack(alignment: .leading) {
                Text(product.name)
                Text("$" + product.price.description)
            }

            Spacer()

            Button {
                viewModel.removeFromCart(product)
            } label: {
                Text("Remove")
                    .frame(width: 80, height: 30)
                    .font(.subheadline)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .buttonStyle(.borderless)
            .padding()
        }
        .background(.black.opacity(0.1))
        .cornerRadius(20)
    }
}

struct CartView: View {
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var viewModel: ProductsViewModel

    @State private var isPurchasedAlertVisible = false

    var body: some View {
        Group {
            if viewModel.cartQuantity > 0 {
                VStack {
                    List(viewModel.cartItems, id: \.self) {
                        ProductRow(cartItem: $0)
                    }

                    Button {
                        isPurchasedAlertVisible.toggle()
                    } label: {
                        Text("Buy Now!")
                            .frame(width: 180, height: 60)
                            .font(.title3)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .buttonStyle(.borderless)
                    .padding(.bottom, 20)
                }
                .alert(isPresented: $isPurchasedAlertVisible, content: {
                    Alert(
                        title: Text("Success!"),
                        message: Text("Your items have been purchased."),
                        dismissButton: .default(Text("OK"), action: {
                            viewModel.clearCart()
                            presentationMode.wrappedValue.dismiss()
                        }))
                })
            } else {
                Text("Cart is Empty")
            }
        }
        .navigationBarTitle(Text("Cart"), displayMode: .inline)

    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
