//
//  MoviesConfigurator.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 16/11/2024.
//

import Foundation

@MainActor
struct MoviesConfigurator {
  var viewModel: MoviesViewModel {
    let apiClient = MoviesAPIClient()
    let repository = MoviesRepository(apiclient: apiClient)
    let useCase = MoviesUseCase(repository: repository)
    
    return MoviesViewModel(useCase: useCase)
  }
}
