import Foundation
import SwiftUI

struct MovieDetailSearchView: View {
    @State private var movieDetails: MovieOmdbapi?
    @State private var isLoading = true
    @State private var errorMessage: String?
    @Environment(\.presentationMode) var presentationMode

    let imdbID: String
    
    var body: some View {
        ZStack {
            // Фон
            Color.black
                .customBackground()
                .edgesIgnoringSafeArea(.all)
            
            Group {
                if isLoading {
                    VStack {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                    }
                } else if let movieDetails = movieDetails {
                    // Відображення деталей фільму
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            // Секція з постером
                            ZStack(alignment: .topLeading) {
                                if let poster = movieDetails.poster, let posterUrl = URL(string: poster) {
                                    CachedAsyncImage(url: posterUrl)
                                        .frame(height: 500)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 500)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                }
                                
                                // Градієнт зверху для кращої видимості кнопки назад
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 100)
                                
                                // Кастомна кнопка назад
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 16, weight: .semibold))
                                        Text("Назад")
                                            .font(.system(size: 16, weight: .semibold))
                                    }
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(
                                        Capsule()
                                            .fill(Color.black.opacity(0.6))
                                    )
                                }
                                .padding(.top, 50)
                                .padding(.leading, 16)
                            }
                            
                            // Контентна частина
                            VStack(alignment: .leading, spacing: 24) {
                                // Назва фільму
                                Text(movieDetails.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.top, 16)
                                
                                // Опис фільму
                                if let plot = movieDetails.plot {
                                    Text(plot)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .lineSpacing(4)
                                        .padding(.horizontal)
                                }
                                
                                // Додаткова інформація
                                VStack(alignment: .leading, spacing: 8) {
                                    if let genre = movieDetails.genre {
                                        Text("Genre: \(genre)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    if let runtime = movieDetails.runtime {
                                        Text("Runtime: \(runtime)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    if let director = movieDetails.director {
                                        Text("Director: \(director)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    if let actors = movieDetails.actors {
                                        Text("Actors: \(actors)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    if let language = movieDetails.language {
                                        Text("Language: \(language)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    if let country = movieDetails.country {
                                        Text("Country: \(country)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    if let awards = movieDetails.awards {
                                        Text("Awards: \(awards)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.top)
                    .navigationBarHidden(true)
                    .customBackground()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            fetchMovieDetails(imdbID: imdbID) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let details):
                        self.movieDetails = details
                        self.isLoading = false
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                    }
                }
            }
        }
    }

    
    func fetchMovieDetails(imdbID: String, completion: @escaping (Result<MovieOmdbapi, Error>) -> Void) {
        let apiKey = AppConstant.omdbapiApiKEY
        let urlString = "https://www.omdbapi.com/?apikey=\(apiKey)&i=\(imdbID)&plot=full".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieDetails = try decoder.decode(MovieOmdbapi.self, from: data)
                completion(.success(movieDetails))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

