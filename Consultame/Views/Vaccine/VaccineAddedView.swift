//
//  VaccineAddedView.swift
//  Consultame
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct VaccineAddedView: View {
    var body: some View {
        VStack {
            Image("virus")
                .resizable()
                .scaledToFit()
                .frame(width: 400, alignment: .center)
                
            Text("Vacuna agregada correctamente")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            .padding()
            .font(.largeTitle)
            .fontWeight(.thin)
            
            
                
            
        } // vstack
    }
}

struct VaccineAddedView_Previews: PreviewProvider {
    static var previews: some View {
        VaccineAddedView()
    }
}
