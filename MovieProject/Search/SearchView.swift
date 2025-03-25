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
                            // Можна додати додаткову логіку при зміні типу
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
                
                // Результати пошуку
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
            .navigationTitle("Пошук")
            .navigationBarTitleDisplayMode(.inline)
            .customBackground()
        }
        .customNavigationBar()
    }
}
struct SearchResultRow: View {
    let movie: MovieOmdbapi
    
    var body: some View {
        HStack(spacing: 12) {
            // Постер
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
