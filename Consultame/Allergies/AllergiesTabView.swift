//
//  AllergiesTabView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct AllergiesTabView: View {
    @State private var selectedTab = 0

    
    var body: some View {
        VStack {
            HStack {
                Text("Mis alergías")
                Spacer()
                NavigationLink(destination: AnyView(AddAllergyToUserView())) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.accentColor)
                } // NavigationLink
                
            } // hstack
            .padding()
            .font(.title)
            
            
            Picker("Tabs", selection: $selectedTab) {
                Text("Medicamentos").tag(0)
                Text("Alimentos").tag(1)
                Text("Otros").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())

            
            TabView(selection: $selectedTab) {
                DrugAllergiesView()
                    .tag(0)
                FoodAllergiesView()
                    .tag(1)
                OtherAllergiesView()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.default)
        }
        } // body
    }
    
    struct AllergiesTabView_Previews: PreviewProvider {
        static var previews: some View {
            AllergiesTabView()
        }
    }
