import SwiftUI

enum SideBarRows: Int, CaseIterable{
    case home = 0
    case profile
    case socio
    case logOut
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        case .socio:
            return "Dilo en Señas"
        case .logOut:
            return "Cerrar sesión"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person"
        case .socio:
            return "hands.sparkles"
        case .logOut:
            return "rectangle.portrait.and.arrow.right"
        }
    }
}

struct SideBarView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack{
                        HStack{
                            Spacer()
                            Image("manoSmall")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                            
                            Spacer()
                        }
                        Text("ConsultaMe")
                            .foregroundColor(.black)
                            .bold()
                    }
                    .padding(.bottom, 50)
                    
                    ForEach(SideBarRows.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, systemImageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                    .padding(20)
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func RowView(isSelected: Bool, systemImageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    ZStack{
                        Image(systemName: systemImageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? Color("AccentColor") : .gray)
                            .frame(width: 30, height: 30)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(isSelected ? Color("AccentColor") : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
    }
}
