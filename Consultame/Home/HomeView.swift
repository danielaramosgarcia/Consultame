import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            ZStack{
                
                VStack {
                    HStack {
                        Spacer()
                        Image("manoSmall")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .toolbar{
                    }
                    Text("ConsultaMe")
                        .foregroundColor(.black)
                        .bold()
                    
                    
                    
                    CustomButton(
                        buttonColor : Color.black,
                        borderColor : Color.clear,
                        text : "+ Empieza una cita",
                        textColor : Color.white,
                        destinationView: AnyView(AppointmentNameView())
                    )
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
                    
                    CitasPrevias()
                }
            }
        }
    
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

