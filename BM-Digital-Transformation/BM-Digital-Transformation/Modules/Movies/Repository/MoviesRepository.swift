//
//  MoviesRepository.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

protocol MoviesRepositoryProtocol {
  func startfetchingMovies(with moviesType: MoviesType) async throws -> MoviesResponse
}

struct MoviesRepository: MoviesRepositoryProtocol {
  // MARK: - Properties
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
}
