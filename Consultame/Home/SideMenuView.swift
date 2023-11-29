//
//  SideMenuView.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 28/11/23.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        List {
            // Side menu options
            Text("Menu Item 1")
            Text("Menu Item 2")
            // Add more menu items as needed
        }
        .background(Color.gray)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
