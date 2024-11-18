//
//  MoviesRepository.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import SwiftUI
import SwiftData

protocol MoviesRepositoryProtocol {
  func startfetchingMovies(with moviesType: MoviesType) async throws -> MoviesResponse
  func startFetchingMovieDetails(with movieId: Int) async throws -> MovieDetailsResponse
  @MainActor
  func saveMovieDetailsResponseInLocalStorage(with movieDetails: MovieDetailsModelData) throws
  @MainActor
  func saveMovieResponseInLocalStorage(with movies: MoviesModelData) throws
  @MainActor
  func startFetchingMoviesListFromLocalStorage() throws -> MoviesModelData?
  @MainActor
  func startFetchingMovieDetailsFromLocalStorage() throws -> MovieDetailsModelData?
}

struct MoviesRepository: MoviesRepositoryProtocol {
  // MARK: - Properties
  private var sharedModelContainer: ModelContainer = {
      let schema = Schema([
        MoviesModelData.self,
        MovieDetailsModelData.self
      ])
      let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

      do {
          return try ModelContainer(for: schema, configurations: [modelConfiguration])
      } catch {
          fatalError("Could not create ModelContainer: \(error)")
      }
  }()
  
  private let apiclient: APIClient
  
  // MARK: - Init Methods
  init(apiclient: APIClient) {
    self.apiclient = apiclient
  }
  
  // MARK: - Methods
  func startfetchingMovies(with moviesType: MoviesType) async throws -> MoviesResponse {
    let request = MoviesRequest.list(page: 1,
                                     language: "en-US",
                                     moviesType: moviesType)
    let moviesResponse: MoviesResponse = try await apiclient.startRequest(with: request)
    
    return moviesResponse
  }
  
  func startFetchingMovieDetails(with movieId: Int) async throws -> MovieDetailsResponse {
    let request = MoviesRequest.details(movieID: movieId)
    
    let movieDetailsResponse: MovieDetailsResponse = try await apiclient.startRequest(with: request)
    
    return movieDetailsResponse
  }

  @MainActor
  func saveMovieDetailsResponseInLocalStorage(with movieDetails: MovieDetailsModelData) throws {
    do {
      sharedModelContainer.mainContext.insert(movieDetails)
      try sharedModelContainer.mainContext.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  @MainActor
  func saveMovieResponseInLocalStorage(with movies: MoviesModelData) throws {
    do {
      sharedModelContainer.mainContext.insert(movies)
      try sharedModelContainer.mainContext.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  @MainActor
  func startFetchingMoviesListFromLocalStorage() throws -> MoviesModelData? {
    do {
      let fetchRequest = FetchDescriptor<MoviesModelData>()
      let moviesDataModel = try sharedModelContainer.mainContext.fetch(fetchRequest)
      
      return moviesDataModel.first
    } catch {
      
      return nil
    }
  }
  
  @MainActor
  func startFetchingMovieDetailsFromLocalStorage() throws -> MovieDetailsModelData? {
    do {
      let fetchRequest = FetchDescriptor<MovieDetailsModelData>()
      let moviesDataModel = try sharedModelContainer.mainContext.fetch(fetchRequest)
      
      return moviesDataModel.first
    } catch {
      return nil
    }
  }
}
