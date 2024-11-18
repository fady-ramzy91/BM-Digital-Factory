//
//  Movie.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import Foundation
import SwiftData

struct MoviesResponse: Codable {
  let results: [Movie]
}

struct Movie: Codable {
  let id: Int
  let overview: String
  let posterPath: String
  let releaseDate: String
  let title: String
}
