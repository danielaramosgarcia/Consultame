//
//  CardRectangle.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 08/11/23.
//

import SwiftUI

struct CardRectangle: View {
    var randomColor = Utils.colors.randomElement() ?? "DefaulColor"
    var backgroundColor : Color{
        Color(randomColor)
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(backgroundColor)
            .frame(height: 100)
    }
}

#Preview {
    CardRectangle()
}
