//
//  APIClient.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 14/11/2024.
//

import Foundation

enum APIError: Error, LocalizedError {
  case inValidURL
  case noInternetConnection
  case serverError
  
  var errorDescription: String? {
    switch self {
    case .inValidURL:
      "Invalid URL"
    case .noInternetConnection:
      "No internet connection"
    case .serverError:
      "Server error"
    }
  }
}

protocol APIClient {
  // MARK: - Properties
  var baseURL: String { get }
  
  // MARK: - Methods
  func startRequest<T>(with request: APIRequest) async throws -> T where T: Codable
  func urlRequest(from apiRequest: APIRequest) async throws -> URLRequest
  func handleReturnedError(with error: URLError) -> APIError
}

extension APIClient {
  func urlRequest(from apiRequest: APIRequest) async throws -> URLRequest {
    guard let url = URL(string: baseURL + apiRequest.path) else {
      throw APIError.inValidURL
    }
    
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    components.queryItems = apiRequest.parameters?.map({ URLQueryItem(name: $0.key, value: $0.value) })
    
    var request = URLRequest(url: components.url!)
    request.httpMethod = apiRequest.method.rawValue
    request.allHTTPHeaderFields = apiRequest.headers
    
    return request
  }
  
  func startRequest<T>(with request: APIRequest) async throws -> T where T: Codable {
    let request = try await urlRequest(from: request)
    
    do {
      let (data, _) = try await URLSession.shared.data(for: request)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let fetchedData = try decoder.decode(T.self, from: data)
      
      return fetchedData
    } catch let error as URLError {
      throw handleReturnedError(with: error)
    }
  }
}
