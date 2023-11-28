//
//  FamilyCoverView.swift
//  Consultame
//
//  Created by Toño on 27/11/23.
//

import SwiftUI

struct AllergiesCoverView: View {
    var body: some View {
        
        VStack{
                Text("Alergias")
                    .font(.system(size: 45, weight: .bold))
                
                
                Text("medicamentos, alimentos y otros...")
                    .font(.system(size: 25, weight: .light))
            
            
            Image("foodAllergies")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 280)
                .padding()
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "¡Vamos!",
                textColor : Color.white,
                destinationView: AnyView(AddAllergyToUserView())
            )
            .padding(.top, 50)
            .padding(.horizontal, 60)
            
            CustomButton(
                buttonColor : Color.clear,
                borderColor : Color("AccentColor"),
                text : "Saltar",
                textColor : Color("AccentColor"),
                destinationView: AnyView(FamilyCoverView())
            )
            .bold()
            .padding(.top, 20)
            .padding(.horizontal, 60)
            .navigationBarBackButtonHidden(true)
        }
       
    }
}

struct AllergiesCoverView_Previews: PreviewProvider {
    static var previews: some View {
        AllergiesCoverView()
    }
}

