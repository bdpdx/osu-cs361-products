//
//  ContentView.swift
//  Products
//
//  Created by Brian Doyle on 2/13/22.
//

import Dispatch
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ProductsViewModel

    var body: some View {
        NavigationView {
            ProductsView()
                .navigationBarTitle(Text("Products"), displayMode: .large)
                .navigationBarItems(leading: NavBarLeadingView())
                .navigationBarItems(trailing: NavBarTrailingView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject private static var viewModel = ProductsViewModel.testModel

    static var previews: some View {
        ContentView()
            .environmentObject(viewModel)
    }
}
