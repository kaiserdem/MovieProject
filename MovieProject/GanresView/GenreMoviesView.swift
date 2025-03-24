import SwiftUI

struct GenreMoviesView: View {
    let genre: Genre
    @StateObject private var viewModel = GenreMoviesViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.movies, id: \.title) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieGridCard(movie: movie)
                    }
                }
            }
            .padding()
        }
        .customBackground()
        .navigationTitle(genre.name)
        .foregroundColor(.white)  // Для маленького заголовка
        .navigationBarTitleTextColor(.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .onAppear {
            viewModel.getMovies(forGenre: genre.id)
        }
    }
}


struct MovieGridCard: View {
    let movie: MovieThemoviedb
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Постер
            if let posterPath = movie.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            // Назва фільму
            Text(movie.title)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.white) 
            
        }
    }
}
