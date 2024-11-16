//
//  Movie.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import Foundation

struct MoviesResponse: Codable {
  let page: Int
  let results: [Movie]
  let totalPages: Int
  let totalResults: Int
}

struct Movie: Codable {
  let adult: Bool
  let backdropPath: String
  let genreIds: [Int]
  let id: Int
  let originalLanguage: String
  let originalTitle: String
  let overview: String
  let popularity: Double
  let posterPath: String
  let releaseDate: String
  let title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
}
