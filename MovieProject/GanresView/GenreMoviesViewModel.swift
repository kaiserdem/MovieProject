
import Foundation
import SwiftUI

class GenreMoviesViewModel: ObservableObject {
    @Published var movies: [MovieThemoviedb] = []
    
    func getMovies(forGenre genreId: Int) {
        for page in 1...10 {
            let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(AppConstant.themoviedbApiKEY)&language=en-US&page=\(page)&with_genres=\(genreId)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data else {
                    print("Помилка завантаження даних: \(error?.localizedDescription ?? "Невідома помилка")")
                    return
                }
                
                do {
                    let movieResponse = try JSONDecoder().decode(MovieThemoviedbList.self, from: data)
                    DispatchQueue.main.async {
                        self?.movies.append(contentsOf: movieResponse.results)
                    }
                } catch {
                    print("Помилка декодування: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
}
