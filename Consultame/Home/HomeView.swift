//
//  HomeView.swift
//  Consultame
//
//  Created by Alumno on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    var consultations = ConsultationViewModel()

    var body: some View {
        VStack {
            BotonEmpezarCita()
            CitasPrevias()
                

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
