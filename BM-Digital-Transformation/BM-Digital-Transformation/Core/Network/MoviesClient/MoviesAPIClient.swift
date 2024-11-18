//
//  MoviesAPIClient.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 14/11/2024.
//

import Foundation

struct MoviesAPIClient: APIClient {
  // MARK: - Properties
  var baseURL: String { "https://api.themoviedb.org/3/" }
  
  // MARK: - Methods
  func handleReturnedError(with error: URLError) -> APIError {
    if error.code == .notConnectedToInternet || error.code == .networkConnectionLost {
      return .noInternetConnection
    }
    
    return .serverError
  }
}
