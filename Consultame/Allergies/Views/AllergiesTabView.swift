//
//  AllergiesTabView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct AllergiesTabView: View {
    @StateObject private var allergiesVM = AllergiesViewModel()

    private let options = ["Medicamentos", "Alimentos", "Otros"]
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            HStack {
                Text("Mis alergías")
                Spacer()
                NavigationLink(destination: AnyView(AddAllergyToUserView())) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.accentColor)
                }
            }
            .padding()
            .font(.title)

            HStack(spacing: 0) {
                ForEach(options.indices, id: \.self) { index in
                    Group {
                        Spacer()
                        
                        Text(options[index])
                            .font(.subheadline)
                            .foregroundColor(selectedTab == index ? Color("AccentColor") : .gray)
                            .overlay(
                                selectedTab == index ?
                                    Rectangle().frame(height: 2).foregroundColor(Color("AccentColor")) :
                                    Rectangle().frame(height: 0).foregroundColor(Color("AccentColor")),
                                alignment: .bottom
                            )
                            .frame(minWidth: 0, maxWidth: .infinity) // This will cause the text to take up equal space
                            .onTapGesture {
                                self.selectedTab = index
                            }
                        
                        Spacer()
                    }
                }
            }
            .padding()

            TabView(selection: $selectedTab) {
                AllergiesListView(allergies: allergiesVM.drugAllergies).tag(0)
                AllergiesListView(allergies: allergiesVM.foodAllergies).tag(1)
                AllergiesListView(allergies: allergiesVM.otherAllergies).tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .task {
            do {
                try await allergiesVM.getAllergy()
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct AllergiesTabView_Previews: PreviewProvider {
    static var previews: some View {
        AllergiesTabView()
    }
}
