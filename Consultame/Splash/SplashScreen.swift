//
//  SplashScreen.swift
//  Consultame
//
//  Created by Daniela Ramos Garcia on 18/10/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 1
    
    var body: some View {
        if isActive {
            AddVaccineToUserView()
        } else {
            Color("morado") // Change the color to your desired color
                .edgesIgnoringSafeArea(.all) //
                .overlay(
                VStack{
                    Image("manoSmall")
                    HStack {
                        Text("ComunicaMe")
                            .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(.white)
                    }
                }
                .scaleEffect(size)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                    }
                }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        )
    }
    
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
