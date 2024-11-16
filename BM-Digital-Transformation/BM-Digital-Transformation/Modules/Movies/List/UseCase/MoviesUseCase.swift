//
//  MoviesUseCase.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import Foundation

struct MovieUIModel: Identifiable {
  let id: Int
  let title: String
  let releaseDate: String
  let imgaeURL: URL
}

protocol MoviesUseCaseProtocol {
  func startFetchingMovies(with moviesType: MoviesType) async throws -> [MovieUIModel]
}

struct MoviesUseCase: MoviesUseCaseProtocol {
  // MARK: - Properties
  private let repository: MoviesRepositoryProtocol
  
  // MARK: - Init Methods
  init (repository: MoviesRepositoryProtocol) {
    self.repository = repository
  }
  
  func startFetchingMovies(with moviesType: MoviesType) async throws -> [MovieUIModel] {
    let movieReponse = try await repository.startfetchingMovies(with: moviesType)
    
    return movieReponse.results.map { MovieUIModel(id: $0.id,
                                                   title: $0.title,
                                                   releaseDate: $0.releaseDate,
                                                   imgaeURL: URL(string: "https://image.tmdb.org/t/p/w500" + $0.posterPath)!) }
  }
}
