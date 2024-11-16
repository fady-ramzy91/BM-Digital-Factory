//
//  MovieDetails.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 16/11/2024.
//

import Foundation

struct MovieDetailsResponse: Codable {
  let id: Int
  let genres: [Genre]
  let overview: String
  let runtime: Int
  let posterPath: String
  let releaseDate: String
  let title: String
}

struct Genre: Codable {
  let id: Int
  let name: String
}
