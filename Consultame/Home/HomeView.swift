import SwiftUI

struct HomeView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
            ZStack{
                
                VStack {
                    ZStack{
                        HStack {
                            Button{
                                presentSideMenu.toggle()
                            } label: {
                                Image(systemName: "line.horizontal.3")
                                    .imageScale(.large)
                                    .padding()
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        HStack{
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
                    
                } // VStack
            } //ZStack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let isSideMenuOpen = Binding.constant(false)

        // Pass the binding to HomeView
        HomeView(presentSideMenu: isSideMenuOpen)
    }
}
