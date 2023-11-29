import SwiftUI

struct CustomButton: View {
    let buttonColor: Color
    let borderColor: Color
    let text: String
    let textColor: Color
    let destinationView: AnyView
    var action: (() -> Void)? // Action closure is now Optional
    var asyncAction: (() -> Void)? // Action closure is now Optional

    
    init(buttonColor: Color, borderColor: Color, text: String, textColor: Color, destinationView: AnyView, action: (() -> Void)? = nil) {
        self.buttonColor = buttonColor
        self.borderColor = borderColor
        self.text = text
        self.textColor = textColor
        self.destinationView = destinationView
        self.action = action
    }
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack {
                Text(text)
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(buttonColor)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(borderColor, lineWidth: 2)
            )
            .cornerRadius(15)
        }
        .simultaneousGesture(TapGesture().onEnded {
            self.action?()  // Conditionally calls the action if it exists
        })
    }
}
