//
//  MoviesRequest.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import Foundation

enum MoviesType: String {
  case popular = "popular"
  case nowPlaying = "now_playing"
  case upcoming = "upcoming"
}

enum MoviesRequest: APIRequest {
  case list(page: Int,
            language: String,
            moviesType: MoviesType)
  
  var method: HTTPMethod {
    switch self {
    case .list:
      .get
    }
  }
  
  var path: String {
    switch self {
    case let .list(_, _, moviesType):
      "movie/\(moviesType.rawValue)"
    }
  }
  
  var parameters: [String : String]? {
    switch self {
    case let .list(page,
                   language, _):
      ["page": String(page),
       "language": language]
    }
  }
}