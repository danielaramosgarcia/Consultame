import SwiftUI

struct HomeView: View {
    @State private var isInCita = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: StartConsultationView(),
                    isActive: $isInCita,
                    label: { EmptyView() }
                )
                .hidden()

                Button("+ Empieza una cita") {
                    isInCita = true
                }
                .buttonStyle(BotonesInicio(buttonColor: Color.black))
                .padding(.top, 50)
                .padding(.horizontal, 25)

                CitasPrevias()
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

