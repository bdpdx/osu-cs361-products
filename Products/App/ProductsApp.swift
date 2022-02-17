//
//  ProductsApp.swift
//  Products
//
//  Created by Brian Doyle on 2/13/22.
//

import SwiftUI
import UIKit

@main
struct ProductsApp: App {
    @StateObject private var viewModel = ProductsViewModel()

    init() {
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
