//
//  VaccinesListView.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct VaccinesListView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Mis vacunas")
                    .padding()
                    .font(.title)
                Spacer()
            } // hstack
            
        } // vstack
        
    }
}

struct VaccinesListView_Previews: PreviewProvider {
    static var previews: some View {
        VaccinesListView()
    }
}
