//
//  MainTabView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct MainTabView: View {
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        
        
        
        VStack{
            //SideTabView()

            NavigationView(){
                ZStack{
                    switch selectedSideMenuTab{
                    case 2:
                        Text("Dilo en señas")
                        
                        
                    case 3:
                        Text("Cerrar sesion")
                        
                    default:
                        TabView(selection: $selectedSideMenuTab) {
                            VStack {
                                HomeView(presentSideMenu: $presentSideMenu)
                                
                                Spacer()
                                
                            }
                            .tabItem{
                                Label("Inicio", systemImage: "house")
                                    .font(.title)
                            }
                            .tag(0)
                            
                            ProfileView(presentSideMenu: $presentSideMenu)
                                .tabItem{
                                    Label("Perfil", systemImage: "person")
                                }
                                .tag(1)
                            
                        }
                    }
                    
                        SideBar(isShowing: $presentSideMenu, content: AnyView(SideBarView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
//                    }
                }
            }
            
        }//NavigationView
        .navigationBarBackButtonHidden(true)
        
    } // body
} // MainTabView

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
