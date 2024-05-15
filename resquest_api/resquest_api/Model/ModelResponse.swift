//
//  ModelResponse.swift
//  resquest_api
//
//  Created by Marcy Barreto on 15/05/24.
//

import Foundation

class ModelResponse: Decodable {
    let page: Int
    let results: [MovieModel]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(page: Int, results: [MovieModel], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

struct MovieModel: Codable, Identifiable, Hashable {
    let originalLanguage: String?
    let originalTitle, overview: String?
    let posterPath, releaseDate, title, backdropPath: String?
    let voteAverage: Double?
    let id: Int
    var isFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, title, id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
    
    init(adult: Bool, backdropPath: String, genreIDS: [Int], id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
        self.backdropPath = backdropPath
        self.id = id
    }
}
