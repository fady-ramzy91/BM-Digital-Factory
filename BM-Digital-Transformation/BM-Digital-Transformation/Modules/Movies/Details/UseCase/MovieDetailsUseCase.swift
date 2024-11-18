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
  let genres: [GenreUIModel]
  let runtime: String
}

struct GenreUIModel: Identifiable {
  let id: Int
  let name: String
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
    do {
      let movieDetailsResponse = try await repository.startFetchingMovieDetails(with: movieId)
      return mapMovieDetailsResponseToUIModel(with: movieDetailsResponse)
    } catch let error as APIError {
      if case .noInternetConnection = error {
        if let movieDetailsModelData = try await repository.startFetchingMovieDetailsFromLocalStorage() {
          return mapMovieDetailsModelDataToUIModel(movieDetailsModelData)
        }
        throw error
      } else {
        throw error
      }
    }
  }
  
  func convertNumberToTime(seconds: Int) -> String {
    let minutes = (seconds % 3600) / 60
    let remainingSeconds = seconds % 60
    
    return String(format: "%02d:%02d", minutes, remainingSeconds)
  }
  
  func mapMovieDetailsModelDataToUIModel(_ detailsModelData: MovieDetailsModelData) -> MovieDetailsUIModel {
    MovieDetailsUIModel(id: detailsModelData.id,
                        title: detailsModelData.title,
                        releaseDate: detailsModelData.releaseDate,
                        imgaeURL: URL(string: "https://image.tmdb.org/t/p/w500" + detailsModelData.posterPath)!,
                        overview: detailsModelData.overview,
                        genres: detailsModelData.genres.map({ GenreUIModel(id: $0.id,
                                                                           name: $0.name) }),
                        runtime: convertNumberToTime(seconds: detailsModelData.runtime))
  }
  
  func mapMovieDetailsResponseToUIModel(with movieDetailsResponse: MovieDetailsResponse) -> MovieDetailsUIModel {
    MovieDetailsUIModel(id: movieDetailsResponse.id,
                        title: movieDetailsResponse.title,
                        releaseDate: movieDetailsResponse.releaseDate,
                        imgaeURL: URL(string: "https://image.tmdb.org/t/p/w500" + movieDetailsResponse.posterPath)!,
                        overview: movieDetailsResponse.overview,
                        genres: movieDetailsResponse.genres.map({ GenreUIModel(id: $0.id,
                                                                               name: $0.name) }),
                        runtime: convertNumberToTime(seconds: movieDetailsResponse.runtime))
  }
}
