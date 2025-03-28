import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    CustomSegmentControl(
                        selectedType: $viewModel.selectedType,
                        onTypeChanged: {
                            if !viewModel.searchText.isEmpty {
                                viewModel.fetchMoviesOnMultiplePages(searchTerm: viewModel.searchText, totalPages: 3)
                            }
                        }
                    )
                    
                    CustomSearchBar(text: $viewModel.searchText) {
                        viewModel.fetchMoviesOnMultiplePages(searchTerm: viewModel.searchText, totalPages: 3)
                    }
                }
                .padding(.top, 16)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.movies, id: \.imdbID) { movie in
                                SearchResultRow(movie: movie)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .customBackground()
        }
        .customNavigationBar()
    }
}

struct SearchResultRow: View {
    let movie: MovieOmdbapi
    
    init(movie: MovieOmdbapi) {
        self.movie = movie
    }
    
    var body: some View {
        NavigationLink(destination: MovieDetailSearchView(imdbID: movie.imdbID)) {
            HStack(spacing: 12) {
                if let posterUrl = URL(string: movie.poster ?? "") {
                    CachedAsyncImage(url: posterUrl)
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 120)
                        .cornerRadius(8)
                }
                
                // Інформація
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(movie.year)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(movie.type.capitalized)
                        .font(.caption)
                        .padding(4)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding(12)
            .background(Color.black.opacity(0.3))
            .cornerRadius(12)
        }
    }
}
