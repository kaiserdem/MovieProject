
import SwiftUI

struct CustomNavigationBarModifier: ViewModifier {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        // Створюємо градієнт
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        gradient.colors = [
            UIColor(red: 0.4, green: 0.2, blue: 0.9, alpha: 0.95).cgColor,  // Фіолетовий
            UIColor(red: 0.9, green: 0.3, blue: 0.5, alpha: 0.95).cgColor,  // Рожевий
            UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 0.95).cgColor   // Помаранчевий
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        // Конвертуємо градієнт в зображення
        UIGraphicsBeginImageContext(gradient.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradient.render(in: context)
            let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            appearance.backgroundImage = backgroundImage
        }
        
        // Налаштування тексту та кольорів
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        // Налаштування кнопок навігації
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
       // appearance.buttonAppearance.normal.tintColor = .white
        
        // Застосовуємо налаштування
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func customNavigationBar() -> some View {
        self.modifier(CustomNavigationBarModifier())
    }
}
