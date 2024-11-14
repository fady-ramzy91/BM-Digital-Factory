//
//  APIClient.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 14/11/2024.
//

import Foundation

enum APIError: Error {
  case invalidURL
}

protocol APIClient {
  func startRequest<T>(with request: APIRequest) async throws -> T where T: Codable
  func urlRequest(from apiRequest: APIRequest) async throws -> URLRequest
}

extension APIClient {
  func urlRequest(from apiRequest: APIRequest) async throws -> URLRequest {
    guard let url = URL(string: apiRequest.path) else {
      throw APIError.invalidURL
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
    let (data, _) = try await URLSession.shared.data(for: request)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let fetchedData = try decoder.decode(T.self, from: data)
    
    return fetchedData
  }
}
