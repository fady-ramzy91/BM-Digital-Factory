//
//  APIRequest.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 14/11/2024.
//

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

import Foundation

protocol APIRequest {
  var method: HTTPMethod { get }
  var path: String { get }
  var parameters: [String: String]? { get }
  var headers: [String: String]? { get }
}
