
import Combine
import Foundation

class SearchViewModel: ObservableObject {
        //@Published var selectedType: MovieType = .movie
    
    
    
    @Published var movies: [MovieOmdbapi] = []
    @Published var searchText = "love"
    @Published var isLoading = false
    @Published var selectedType: MovieType = .movie {
        
        didSet {
            // При зміні типу оновлюємо результати пошуку
            if !searchText.isEmpty {
                fetchMoviesOnMultiplePages(searchTerm: searchText, totalPages: 3)
            }
        }
    }
    
    init() {
            // Виконуємо початковий пошук при ініціалізації
            fetchMoviesOnMultiplePages(searchTerm: searchText, totalPages: 3)
        }
    
    func fetchMoviesOnMultiplePages(searchTerm: String, totalPages: Int) {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        movies = [] // Очищаємо попередні результати
        
        let apiKey = AppConstant.omdbapiApiKEY
        
        for page in 1...totalPages {
            let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&s=\(searchTerm)&page=\(page)&type=\(selectedType.rawValue)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            guard let url = URL(string: urlString) else {
                print("not valid url")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    print("Error:", error ?? "Unknown error")
                    DispatchQueue.main.async {
                        self?.isLoading = false
                    }
                    return
                }
                
                
                do {
                    let decoder = JSONDecoder()
                    let searchResult = try decoder.decode(SearchResult.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.movies.append(contentsOf: searchResult.search)
                        if page == totalPages || self?.selectedType == .game {
                            self?.isLoading = false
                        }
                    }
                } catch {
                    print("Decoding error:", error)
                    DispatchQueue.main.async {
                        self?.isLoading = false
                    }
                }
            }
            
            task.resume()
        }
    }
}
