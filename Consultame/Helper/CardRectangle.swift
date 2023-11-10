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
    var textColor: Color{
        isColorDark(backgroundColor) ? Color.white : Color.black
    }
    var cardHeight: CGFloat = 100
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(backgroundColor)
            .frame(height: cardHeight)
    }
}

#Preview {
    CardRectangle()
}
