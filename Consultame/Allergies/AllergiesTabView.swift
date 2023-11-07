//
//  AllergiesTabView.swift
//  Consultame
//
//  Created by Alumno on 05/11/23.
//

import SwiftUI

struct AllergiesTabView: View {
    private let options = ["Medicamentos", "Alimentos", "Otros"]
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            HStack {
                Text("Mis alergías")
                    .font(.title)
                Spacer()
                NavigationLink(destination: AnyView(AddAllergyToUserView())) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.accentColor)
                }
            }
            .padding()

            // Custom Picker with evenly distributed options and underline for the selected text
            HStack(spacing: 0) {  // Set spacing to 0 to control it manually with Spacers
                ForEach(options.indices, id: \.self) { index in
                    Group {
                        Spacer()  // Add a spacer before the text
                        
                        Text(options[index])
                            .font(.subheadline)  // Smaller font size here
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                            .overlay(
                                selectedTab == index ?
                                    Rectangle().frame(height: 2).foregroundColor(.blue) :
                                    Rectangle().frame(height: 0).foregroundColor(.clear),
                                alignment: .bottom
                            )
                            .frame(minWidth: 0, maxWidth: .infinity) // This will cause the text to take up equal space
                            .onTapGesture {
                                self.selectedTab = index
                            }
                        
                        Spacer()  // Add a spacer after the text
                    }
                }
            }
            .padding(.vertical, 10)

            TabView(selection: $selectedTab) {
                DrugAllergiesView().tag(0)
                FoodAllergiesView().tag(1)
                OtherAllergiesView().tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .padding()
    }
}

struct AllergiesTabView_Previews: PreviewProvider {
    static var previews: some View {
        AllergiesTabView()
    }
}
