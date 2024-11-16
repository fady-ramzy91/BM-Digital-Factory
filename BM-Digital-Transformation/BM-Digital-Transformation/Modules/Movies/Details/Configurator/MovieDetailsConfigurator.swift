//
//  MovieDetailsConfigurator.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 16/11/2024.
//

import Foundation

struct MovieDetailsConfigurator {
  let movieId: Int
  
  var viewModel: MoviewDetailsViewModel {
    let apiClient = MoviesAPIClient()
    let repository = MoviesRepository(apiclient: apiClient)
    let useCase = MovieDetailsUseCase(movieId: movieId,
                                      repository: repository)
    
    return MoviewDetailsViewModel(useCase: useCase)
  }
}
