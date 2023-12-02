//
//  FamilyCoverView.swift
//  Consultame
//
//  Created by Toño on 27/11/23.
//

import SwiftUI

struct PersonalCoverView: View {
    var body: some View {
        
        VStack{
            Text("Datos")
                .font(.system(size: 25, weight: .light))

            
            Text("Personales")
                .font(.system(size: 45, weight: .bold))
            
            
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 280)
                .padding()
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "Añadir",
                textColor : Color.white,
                destinationView: AnyView(PersonalView())
            )
            .padding(.top, 50)
            .padding(.horizontal, 60)
            
            CustomButton(
                buttonColor : Color.clear,
                borderColor : Color("AccentColor"),
                text : "Siguiente",
                textColor : Color("AccentColor"),
                destinationView: AnyView(ContactsCoverView())
            )
            .bold()
            .padding(.top, 20)
            .padding(.horizontal, 60)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PersonalCoverView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalCoverView()
    }
}

