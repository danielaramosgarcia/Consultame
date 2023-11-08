//
//  CardRectangle.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 08/11/23.
//

import SwiftUI

struct CardRectangle: View {
    let backgroundColor = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(backgroundColor)
            .frame(height: 100)
        
    }
}

#Preview {
    CardRectangle()
}
