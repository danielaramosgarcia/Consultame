//
//  StartHistoryView.swift
//  Consultame
//
//  Created by Alumno on 03/11/23.
//

import SwiftUI

struct StartHistoryView: View {
    var body: some View {
            ZStack(alignment: .top) {
                Color.white
                
                Image("heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 200) //
            }
        }
        
}

struct StartHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        StartHistoryView()
    }
}
