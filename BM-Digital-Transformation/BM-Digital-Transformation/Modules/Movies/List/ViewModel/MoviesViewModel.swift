//
//  MoviesViewModel.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import Foundation
import SwiftUICore

@MainActor
@Observable
final class MoviesViewModel {
  // MARK: - Properties
  var showErrorMessagePopup: Bool = false
  var movies: [MovieUIModel] = []  
  private let useCase: MoviesUseCaseProtocol
  
  // MARK: - Init Methods
  init(useCase: MoviesUseCaseProtocol) {
    self.useCase = useCase
  }
  
  func startFetchingMovies(with moviesType: MoviesType) async throws {
    do {
      movies = try await useCase.startFetchingMovies(with: moviesType)
    } catch {
      showErrorMessagePopup = true
    }
  }
}
