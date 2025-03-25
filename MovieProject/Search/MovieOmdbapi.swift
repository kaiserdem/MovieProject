
import Foundation

struct MovieOmdbapi: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String?
    let genre: String?
    let ratings: [Rating]?
    let plot: String?
    let director: String?
    let actors: String?
    let runtime: String?
    let language: String?
    let country: String?
    let awards: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case genre = "Genre"
        case ratings = "Ratings"
        case plot = "Plot"
        case director = "Director"
        case actors = "Actors"
        case runtime = "Runtime"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
    }
}

struct Rating: Codable {
    let source, value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}


struct SearchResult: Codable {
    let search: [MovieOmdbapi]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}
