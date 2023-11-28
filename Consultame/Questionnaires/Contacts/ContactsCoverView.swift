//
//  FamilyCoverView.swift
//  Consultame
//
//  Created by Toño on 27/11/23.
//

import SwiftUI

struct ContactsCoverView: View {
    var body: some View {
        
        VStack{
            Text("Contacos")
                .font(.system(size: 45, weight: .bold))

            
            Text("de emergencia")
                .font(.system(size: 30, weight: .light))
            
            
            Image("contactspic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 280)
                .padding()
            
            CustomButton(
                buttonColor : Color("AccentColor"),
                borderColor : Color.clear,
                text : "¡Vamos!",
                textColor : Color.white,
                destinationView: AnyView(ContactsQuestionsView())
            )
            .padding(.top, 50)
            .padding(.horizontal, 60)
            
            CustomButton(
                buttonColor : Color.clear,
                borderColor : Color("AccentColor"),
                text : "Saltar",
                textColor : Color("AccentColor"),
                destinationView: AnyView(HabitsCoverView())
            )
            .bold()
            .padding(.top, 20)
            .padding(.horizontal, 60)
            .navigationBarBackButtonHidden(true)
        }
       
    }
}

struct ContactsCoverView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsCoverView()
    }
}

