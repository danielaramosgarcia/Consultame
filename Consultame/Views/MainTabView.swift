//
//  MainTabView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ProfileView()
                .badge("!")
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle.fill")
                }
        } // TabView
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
