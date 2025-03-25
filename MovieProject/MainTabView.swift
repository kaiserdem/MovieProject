import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CategoriesView()
                .tabItem {
                    Image(systemName: "film.stack")
                    Text("Categories")
                }
            
            GanresView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Ganres")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            
            // Градієнт
            let gradient = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
            gradient.colors = [
                UIColor(red: 0.9, green: 0.3, blue: 0.5, alpha: 0.95).cgColor,  // Рожевий
                UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 0.95).cgColor,   // Помаранчевий
                UIColor(red: 0.4, green: 0.2, blue: 0.9, alpha: 0.95).cgColor  // Фіолетовий
                
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
            
            // Неактивні вкладки - білий напівпрозорий
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.white.withAlphaComponent(0.7)
            ]
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.7)
            
            // Активна вкладка - чорний
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.black
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.black
            
            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}


//struct ContentView: View {
//    var body: some View {
//        TabView {
//            CategoriesView()
//                .tabItem {
//                    Image(systemName: "film.stack")
//                    Text("Категорії")
//                }
//            
//            GanresView()
//                .tabItem {
//                    Image(systemName: "list.bullet.rectangle")
//                    Text("Жанри")
//                }
//            
//            SearchView()
//                .tabItem {
//                    Image(systemName: "magnifyingglass")
//                    Text("Пошук")
//                }
//        }
//        .onAppear {
//            // Налаштування зовнішнього вигляду TabBar
//            let appearance = UITabBarAppearance()
//            appearance.configureWithDefaultBackground()
//            
//            // Створюємо градієнтний фон
//            let gradient = CAGradientLayer()
//            gradient.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
////            gradient.colors = [
////                UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 0.95).cgColor,
////                UIColor(red: 0.2, green: 0.2, blue: 0.3, alpha: 0.95).cgColor
////            ]
//            
////            gradient.colors = [
////                UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 0.95).cgColor,
////                UIColor(red: 0.3, green: 0.2, blue: 0.4, alpha: 0.95).cgColor
////            ]
//
//            // Варіант 2: Синій з бірюзовим
////            gradient.colors = [
////                UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.95).cgColor,
////                UIColor(red: 0.2, green: 0.3, blue: 0.4, alpha: 0.85).cgColor
////            ]
//
////            // Варіант 3: Темний з золотим
////            gradient.colors = [
////                UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.95).cgColor,
////                UIColor(red: 0.3, green: 0.3, blue: 0.2, alpha: 0.95).cgColor
////            ]
//            
//            
////            gradient.colors = [
////                UIColor(red: 0.4, green: 0.2, blue: 0.9, alpha: 0.95).cgColor,  // Фіолетовий
////                UIColor(red: 0.9, green: 0.3, blue: 0.5, alpha: 0.95).cgColor,  // Рожевий
////                UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 0.95).cgColor   // Помаранчевий
////            ]
////            
////            gradient.colors = [
////                UIColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 0.95).cgColor,
////                UIColor(red: 0.8, green: 0.2, blue: 0.8, alpha: 0.95).cgColor,
////                UIColor(red: 0.9, green: 0.8, blue: 0.2, alpha: 0.95).cgColor
////            ]
////
////            // Варіант 2: Бірюзовий -> Рожевий -> Фіолетовий
////            gradient.colors = [
////                UIColor(red: 0.2, green: 0.8, blue: 0.8, alpha: 0.95).cgColor,
////                UIColor(red: 0.9, green: 0.4, blue: 0.6, alpha: 0.95).cgColor,
////                UIColor(red: 0.6, green: 0.2, blue: 0.9, alpha: 0.95).cgColor
////            ]
//
//            // Варіант 3: Зелений -> Жовтий -> Червоний
////            gradient.colors = [
////                UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 0.95).cgColor,
////                UIColor(red: 0.9, green: 0.8, blue: 0.2, alpha: 0.95).cgColor,
////                UIColor(red: 0.9, green: 0.2, blue: 0.3, alpha: 0.95).cgColor
////            ]
//            
//            gradient.colors = [
//                UIColor(red: 0.9, green: 0.3, blue: 0.5, alpha: 0.95).cgColor,  // Рожевий
//                UIColor(red: 0.9, green: 0.5, blue: 0.2, alpha: 0.95).cgColor,   // Помаранчевий
//                UIColor(red: 0.4, green: 0.2, blue: 0.9, alpha: 0.95).cgColor  // Фіолетовий
//
//            ]
//            
//            gradient.startPoint = CGPoint(x: 0, y: 0)
//            gradient.endPoint = CGPoint(x: 1, y: 0)
//            
//            // Конвертуємо градієнт в зображення
//            UIGraphicsBeginImageContext(gradient.bounds.size)
//            if let context = UIGraphicsGetCurrentContext() {
//                gradient.render(in: context)
//                let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                
//                // Встановлюємо зображення як фон
//                appearance.backgroundImage = backgroundImage
//            }
//            
//            // Налаштування кольорів тексту та іконок
//            appearance.stackedLayoutAppearance.normal.iconColor = .gray
//            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
//            
//            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 0.9, green: 0.5, blue: 0.5, alpha: 1.0)
//            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(red: 0.9, green: 0.5, blue: 0.5, alpha: 1.0)]
//            
//            // Застосовуємо налаштування
//            UITabBar.appearance().standardAppearance = appearance
//            if #available(iOS 15.0, *) {
//                UITabBar.appearance().scrollEdgeAppearance = appearance
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
