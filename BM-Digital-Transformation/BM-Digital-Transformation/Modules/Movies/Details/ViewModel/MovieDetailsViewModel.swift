//
//  MovieDetailsViewModel.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 16/11/2024.
//

import Foundation

@Observable
final class MoviewDetailsViewModel {
  // MARK: - Dependencies
  private let useCase: MovieDetailsUseCaseProtocol
  
  // MARK: - Properties
  var movieDetailsUIModel: MovieDetailsUIModel?
  
  // MARK: - Init Methods
  init(useCase: MovieDetailsUseCaseProtocol) {
    self.useCase = useCase
  }
  
  func startFetchingMovieDetails() async throws {
    movieDetailsUIModel = try await useCase.startFetchingMovieDetails()
  }
}
