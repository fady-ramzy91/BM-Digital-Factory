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

@MainActor
struct MoviesUseCase: MoviesUseCaseProtocol {
  // MARK: - Properties
  private let repository: MoviesRepositoryProtocol
  
  // MARK: - Init Methods
  init (repository: MoviesRepositoryProtocol) {
    self.repository = repository
  }
  
  func startFetchingMovies(with moviesType: MoviesType) async throws -> [MovieUIModel] {
    do {
      let movieReponse = try await repository.startfetchingMovies(with: moviesType)
     
      try saveMoviesDataInLocalStorage(movieReponse)
      
      return mapMoviesToUIModel(movieReponse)
    } catch let error as APIError {
      if case .noInternetConnection = error {
        if let moviesModelData = try repository.startFetchingMoviesListFromLocalStorage() {
          return mapMoviesModelDataToUIModel(moviesModelData)
        }
        throw error
      } else {
        throw error
      }
    }
  }
  

  func saveMoviesDataInLocalStorage(_ moviesResponse: MoviesResponse) throws {
    let moviesModelData =  MoviesModelData(list: mapMoviesToModelData(moviesResponse))
    try repository.saveMovieResponseInLocalStorage(with: moviesModelData)
  }
  
  func mapMoviesModelDataToUIModel(_ response: MoviesModelData) -> [MovieUIModel] {
    response.list.map { MovieUIModel(id: $0.id,
                                     title: $0.title,
                                     releaseDate: $0.releaseDate,
                                     imgaeURL: $0.imageURL)
    }
  }
  
  func mapMoviesToModelData(_ response: MoviesResponse) -> [MovieModelData] {
    response.results.map { MovieModelData(id: $0.id,
                                          title: $0.title,
                                          releaseDate: $0.releaseDate,
                                          imageURL: URL(string: "https://image.tmdb.org/t/p/w500" + $0.posterPath)! )}
  }
  
  func mapMoviesToUIModel(_ response: MoviesResponse) -> [MovieUIModel] {
    response.results.map { MovieUIModel(id: $0.id,
                                        title: $0.title,
                                        releaseDate: $0.releaseDate,
                                        imgaeURL: URL(string: "https://image.tmdb.org/t/p/w500" + $0.posterPath)!) }
  }
}
