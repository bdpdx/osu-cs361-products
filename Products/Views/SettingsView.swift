//
//  SettingsView.swift
//  Products
//
//  Created by Brian Doyle on 2/15/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ProductsViewModel

    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                Toggle("Are you over 21?", isOn: $viewModel.isUserOver21)
                Toggle("Do you really like Pokemon?", isOn: $viewModel.isUserAPokemonFan)
            }
        }
        .navigationBarTitle(Text("Settings"), displayMode: .inline)

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
