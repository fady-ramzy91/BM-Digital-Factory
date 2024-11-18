//
//  MovieModelData.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 17/11/2024.
//

import Foundation
import SwiftData

@Model
final class MoviesModelData {
  // MARK: - Properties
  var list: [MovieModelData]
  
  // MARK: - Init Methods
  init(list: [MovieModelData]) {
    self.list = list
  }
}


@Model
final class MovieModelData {
  var id: Int
  var title: String
  var releaseDate: String
  var imageURL: URL
  
  init(id: Int, title: String, releaseDate: String, imageURL: URL) {
    self.id = id
    self.title = title
    self.releaseDate = releaseDate
    self.imageURL = imageURL
  }
}
