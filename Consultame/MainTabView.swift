//
//  MainTabView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var isSideMenuOpen: Bool = false // State variable to track side menu visibility

    var body: some View {
        NavigationView{
            TabView {
                
                VStack {
                 HStack{
                     if isSideMenuOpen {
                         SideMenuView()
                             
                             .frame(width: UIScreen.main.bounds.height * 0.4) // Set width to half the screen width
//                                .transition(.push(from: .trailing))
                             .onTapGesture {
                                 withAnimation {
                                     self.isSideMenuOpen.toggle()
                                 }
                             }
                     }
                        HomeView()
                            .navigationBarItems(trailing:
                                Button(action: {
                                    withAnimation {
                                        self.isSideMenuOpen.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                        .padding()
                                }
                            )

                    }

                    Spacer()

                }
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                                        
                    }
                
                ProfileView()
                    .badge("!")
                    .tabItem {
                        Label("Perfil", systemImage: "person.crop.circle.fill")
                    }
            } // TabView
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
