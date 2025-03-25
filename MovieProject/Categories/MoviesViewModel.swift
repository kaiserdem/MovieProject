import Combine
import Foundation

class MoviesViewModel: ObservableObject {
    @Published var movies: [MovieThemoviedb] = []
    @Published var tvShows: [TVThemoviedb] = []
    @Published var persons: [PersonThemoviedb] = []  

    
    func fetchPopularMovies() {
        for page in 1...10 {
            let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(AppConstant.themoviedbApiKEY)&language=en-US&page=\(page)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    print("Request error: \(error?.localizedDescription ?? "No error message")")
                    return
                }
                
                do {
                    let movieResponse = try JSONDecoder().decode(MovieThemoviedbList.self, from: data)
                    DispatchQueue.main.async {
                        self?.movies.append(contentsOf: movieResponse.results)
                    }
                } catch {
                    print("PopularMovies Decoding error: \(error.localizedDescription), \(page), \(url)")
                }
            }
            task.resume()
        }
    }
    
    func fetchPopularTVShows() {
            for page in 1...10 {
                let urlString = "https://api.themoviedb.org/3/tv/popular?api_key=\(AppConstant.themoviedbApiKEY)&language=en-US&page=\(page)"
                
                guard let url = URL(string: urlString) else {
                    print("Invalid URL")
                    return
                }
                
                let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    guard let data = data, error == nil else {
                        print("Request error: \(error?.localizedDescription ?? "No error message")")
                        return
                    }
                    
                    do {
                        let tvResponse = try JSONDecoder().decode(TVDetails.self, from: data)
                        DispatchQueue.main.async {
                            if let shows = self?.tvShows {
                                self?.tvShows = shows + tvResponse.results
                            }
                        }
                    } catch {
                        print("TVShows, Decoding error: \(error.localizedDescription), \(page), \(url)")
                    }
                }
                task.resume()
            }
        }
    
    
    func fetchPerson() {
            // Спочатку завантажимо першу сторінку
            fetchPersonPage(1) { [weak self] success in
                if success {
                    // Якщо перша сторінка успішно завантажена, завантажуємо інші
                    for page in 2...10 {
                        self?.fetchPersonPage(page)
                    }
                }
            }
        }
    
    private func fetchPersonPage(_ page: Int, completion: ((Bool) -> Void)? = nil) {
        let urlString = "https://api.themoviedb.org/3/person/popular?api_key=\(AppConstant.themoviedbApiKEY)&language=en-US&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion?(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                print("Request error: \(error?.localizedDescription ?? "No error message")")
                completion?(false)
                return
            }
            
            // Друкуємо отриманий JSON
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("=== Person API Response for page \(page) ===")
//                print(jsonString)
//                print("=======================================")
//            }
            
            do {
                let movieResponse = try JSONDecoder().decode(PersonListThemoviedb.self, from: data)
                DispatchQueue.main.async {
                    if let currentPersons = self?.persons {
                        self?.persons = currentPersons + movieResponse.results
                    }
                    completion?(true)
                }
            } catch {
                print("Person Decoding error: \(error.localizedDescription), \(page), \(url)")
                completion?(false)
            }
        }
        task.resume()
    }
}
