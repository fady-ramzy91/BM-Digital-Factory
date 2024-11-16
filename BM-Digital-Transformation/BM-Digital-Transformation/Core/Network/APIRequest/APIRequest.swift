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

extension APIRequest {
  var headers: [String : String]? {
    [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDVhNTY3MmY0NzQ1YzE2OGE1NThjZjVlMWU4YWUyZCIsIm5iZiI6MTczMTYxMDExOC40MTE4NTMzLCJzdWIiOiI2NzM2NDM3MjI5NTRkMjY0NzYyNTk2Y2IiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.Td2Ib6X_ihQ-vKHaV3jZOoPFj4aVztEMywVopI9RHvo"
    ]
  }
}
