import Foundation

struct MovieThemoviedb: Codable {
    let title: String
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case posterPath = "poster_path"
    }
}

struct MovieThemoviedbList: Codable {
    let results: [MovieThemoviedb]
}
