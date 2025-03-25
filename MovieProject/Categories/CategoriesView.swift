import SwiftUI

struct CategoriesView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Топ фільмів
                    CategorySection(title: "Popular movies") {
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 15) {
                                                    ForEach(viewModel.movies, id: \.title) { movie in
                                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                                            MovieCard(movie: movie)
                                                        }
                                                    }
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                    
                    // Топ серіалів
                    CategorySection(title: "Popular TV series") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(viewModel.tvShows, id: \.name) { show in
                                    NavigationLink(destination: TVShowDetailView(show: show)) {
                                        TVShowCard(show: show)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Популярні персони
                    CategorySection(title: "Popular people") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(viewModel.persons, id: \.id) { person in
                                    NavigationLink(destination: PersonDetailView(person: person)) {
                                        PersonCard(person: person)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .customBackground()
            .navigationTitle("Categories")
            .foregroundColor(.white)  // Для маленького заголовка
            .navigationBarTitleTextColor(.white)
        }
        .customNavigationBar()
        .onAppear {
            viewModel.fetchPopularMovies()
            viewModel.fetchPopularTVShows()
            viewModel.fetchPerson()
        }
    }
}

// Додамо новий компонент для TV Shows
struct TVShowCard: View {
    let show: TVThemoviedb
    
    var body: some View {
        VStack(alignment: .leading) {
            if let posterPath = show.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 150, height: 225)
                .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 225)
                    .cornerRadius(10)
            }
            
            Text(show.name ?? "")
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .frame(width: 150)
        }
    }
}

struct PersonCard: View {
    let person: PersonThemoviedb
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if let profilePath = person.profilePath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 120)
            }
            
            VStack(spacing: 4) {
                Text(person.name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text(person.knownForDepartment)
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            .frame(width: 120)
        }
    }
}

struct MovieCard: View {
    let movie: MovieThemoviedb
    
    var body: some View {
        VStack(alignment: .leading) {
            if let posterPath = movie.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(width: 150, height: 225)
                .cornerRadius(10)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 225)
                    .cornerRadius(10)
            }
            
            Text(movie.title)
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(.white) // Змінюємо колір тексту для NavigationLink
                .multilineTextAlignment(.leading)
                .frame(width: 150)
        }
    }
}

struct CategorySection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            content
        }
    }
}


extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        return self
    }
}
