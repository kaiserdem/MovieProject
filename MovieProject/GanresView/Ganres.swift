import SwiftUI

struct GanresView: View {
    @State private var genres: [Genre] = []
    
    // Масив кольорів для карток
    private let colors: [Color] = [
        .blue, .purple, .pink, .orange, .green,
        .indigo, .red, .teal, .mint, .cyan
    ]
    
    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(genres, id: \.id) { genre in
                            NavigationLink(destination: GenreMoviesView(genre: genre)) {
                                GenreCard(genre: genre, color: colors[genre.id % colors.count])
                            }
                        }
                    }
                    .padding()
                }
                .customBackground()
                .navigationTitle("Жанри")
                .foregroundColor(.white)  // Для маленького заголовка
                .navigationBarTitleTextColor(.white)
                .onAppear {
                    loadJson()
                }
            }
        }
    
    private func loadJson() {
        if let url = Bundle.main.url(forResource: "genres", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let genresList = try decoder.decode(GenresList.self, from: data)
                self.genres = genresList.genres
            } catch {
                print("Error loading JSON file: \(error)")
            }
        } else {
            print("Unable to locate JSON file")
        }
    }
}

struct GenreCard: View {
    let genre: Genre
    let color: Color
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(color.opacity(0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(color.opacity(0.3), lineWidth: 1)
                    )
                
                VStack(spacing: 12) {
                    Image(systemName: iconForGenre(genre.name))
                        .font(.system(size: 30))
                        .foregroundColor(color)
                    
                    Text(genre.name)
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                }
                .padding(.vertical, 20)
            }
            .frame(height: 120)
        }
    
    // Функція для підбору іконок залежно від жанру
    private func iconForGenre(_ genre: String) -> String {
        switch genre.lowercased() {
        case "action": return "bolt.fill"
        case "adventure": return "map.fill"
        case "animation": return "sparkles"
        case "comedy": return "face.smiling.fill"
        case "crime": return "lock.fill"
        case "documentary": return "doc.fill"
        case "drama": return "theatermasks.fill"
        case "family": return "person.3.fill"
        case "fantasy": return "wand.and.stars"
        case "history": return "book.fill"
        case "horror": return "ghost"
        case "music": return "music.note"
        case "mystery": return "magnifyingglass"
        case "romance": return "heart.fill"
        case "science fiction": return "airplane"
        case "tv movie": return "tv.fill"
        case "thriller": return "exclamationmark.triangle.fill"
        case "war": return "shield.fill"
        case "western": return "sunset.fill"
        default: return "film.fill"
        }
    }
}

// Попередній перегляд
struct GanresView_Previews: PreviewProvider {
    static var previews: some View {
        GanresView()
    }
}
