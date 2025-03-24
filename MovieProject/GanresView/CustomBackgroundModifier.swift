import SwiftUI
import UIKit
import Foundation

struct CustomBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.1, green: 0.05, blue: 0.2),  // Темно-фіолетовий
                        Color(red: 0.15, green: 0.1, blue: 0.25), // Темно-синій
                        Color(red: 0.2, green: 0.1, blue: 0.3)    // Темно-пурпурний
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
    }
}

extension View {
    func customBackground() -> some View {
        self.modifier(CustomBackgroundModifier())
    }
}
