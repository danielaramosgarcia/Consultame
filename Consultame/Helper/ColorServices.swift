//
//  ColorServices.swift
//  Consultame
//
//  Created by Alberto Tamez Gonzalez on 08/11/23.
//

import Foundation
import SwiftUI


func isColorDark(_ color: Color) -> Bool {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    let brightness = ((red * 299) + (green * 587) + (blue * 114)) / 1000
    return brightness < 0.5
}
