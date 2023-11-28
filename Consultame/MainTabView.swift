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
                VStack{
                ZStack {
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
                    if isSideMenuOpen {
                        SideMenuView()
                            .frame(width: UIScreen.main.bounds.width * 0.5) // Set width to 1/3 of the screen width
                            .offset(x: isSideMenuOpen ? -97 : -UIScreen.main.bounds.width * 0.5)
                            .onTapGesture {
                                withAnimation {
                                    self.isSideMenuOpen.toggle()
                                }
                            }
                            .transition(.move(edge: .leading))
                            .zIndex(1)
                    }
                }
                    Spacer()
                }
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                                        
                    }
                
                VStack{
                ZStack {
                    
                    ProfileView()
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
                    if isSideMenuOpen {
                        SideMenuView()
                            .frame(width: UIScreen.main.bounds.width * 0.5) // Set width to 1/3 of the screen width
                            .offset(x: isSideMenuOpen ? -97 : -UIScreen.main.bounds.width * 0.5)
                            .onTapGesture {
                                withAnimation {
                                    self.isSideMenuOpen.toggle()
                                }
                            }
                            .transition(.move(edge: .leading))
                            .zIndex(1)
                    }
                }
                    Spacer()
                }
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
