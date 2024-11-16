//
//  MovieDetailsUseCase.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 16/11/2024.
//

import Foundation

struct MovieDetailsUIModel: Identifiable {
  let id: Int
  let title: String
  let releaseDate: String
  let imgaeURL: URL
  let overview: String
  let genres: [String]
  let runtime: String
}

protocol MovieDetailsUseCaseProtocol {
  func startFetchingMovieDetails() async throws -> MovieDetailsUIModel
}

struct MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
  // MARK: - Properties
  private let movieId: Int
  private let repository: MoviesRepositoryProtocol
  
  // MARK: - Init Methods
  init (movieId: Int,
        repository: MoviesRepositoryProtocol) {
    self.movieId = movieId
    self.repository = repository
  }
  
  // MARK: - Methods
  func startFetchingMovieDetails() async throws -> MovieDetailsUIModel {
    let movieDetailsResponse = try await repository.startFetchingMovieDetails(with: movieId)
    
    return mapMovieDetailsResponseToUIModel(with: movieDetailsResponse)
  }
  
  
  func convertNumberToTime(seconds: Int) -> String {
      let minutes = (seconds % 3600) / 60
      let remainingSeconds = seconds % 60

      return String(format: "%02d:%02d", minutes, remainingSeconds)
  }
  
  func mapMovieDetailsResponseToUIModel(with movieDetailsResponse: MovieDetailsResponse) -> MovieDetailsUIModel {
    MovieDetailsUIModel(id: movieDetailsResponse.id,
                        title: movieDetailsResponse.title,
                        releaseDate: movieDetailsResponse.releaseDate,
                        imgaeURL: URL(string: "https://image.tmdb.org/t/p/w500" + movieDetailsResponse.posterPath)!,
                        overview: movieDetailsResponse.overview,
                        genres: movieDetailsResponse.genres.map({ $0.name }),
                        runtime: convertNumberToTime(seconds: movieDetailsResponse.runtime))
  }
}
