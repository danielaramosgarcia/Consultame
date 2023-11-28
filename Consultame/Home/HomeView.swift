import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        ZStack{
            
            VStack {
                
                CustomButton(
                    buttonColor : Color.black,
                    borderColor : Color.clear,
                    text : "+ Empieza una cita",
                    textColor : Color.white,
                    destinationView: AnyView(AppointmentNameView())
                )
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

