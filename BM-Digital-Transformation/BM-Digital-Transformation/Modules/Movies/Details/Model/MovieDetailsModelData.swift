//
//  MovieDetailsModelData.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 18/11/2024.
//

import Foundation
import SwiftData

@Model
final class MovieDetailsModelData {
  var id: Int
  var genres: [GenreModelData]
  var overview: String
  var runtime: Int
  var posterPath: String
  var releaseDate: String
  var title: String
  
  init(id: Int,
       genres: [GenreModelData],
       overview: String,
       runtime: Int,
       posterPath: String,
       releaseDate: String,
       title: String) {
    self.id = id
    self.genres = genres
    self.overview = overview
    self.runtime = runtime
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.title = title
  }
}

@Model
final class GenreModelData {
  var id: Int
  var name: String
  
  init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
