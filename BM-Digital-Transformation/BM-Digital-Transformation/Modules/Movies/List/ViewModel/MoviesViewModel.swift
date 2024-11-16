//
//  MoviesViewModel.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import Foundation

@Observable
final class MoviesViewModel {
  // MARK: - Properties
  private let useCase: MoviesUseCaseProtocol
  var movies: [MovieUIModel] = []
  
  // MARK: - Init Methods
  init(useCase: MoviesUseCaseProtocol) {
    self.useCase = useCase
  }
  
  func startFetchingMovies(with moviesType: MoviesType) async throws {
    movies = try await useCase.startFetchingMovies(with: moviesType)
  }
}
