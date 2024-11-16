//
//  UpcomingMoviesView.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import SwiftUI

struct UpcomingMoviesView: View {
  private let viewModel: MoviesViewModel
  
  init(viewModel: MoviesViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(viewModel.movies) { movie in
          let detailsViewModel = MovieDetailsConfigurator(movieId: movie.id).viewModel
          NavigationLink {
            MovieDetailsContentView(movieDetailsViewModel: detailsViewModel)
          } label: {
            MovieView(movie: movie)
          }
        }
      }.navigationTitle("Upcoming Movies")
    }.onAppear() {
      Task {
        try await viewModel.startFetchingMovies(with: .upcoming)
      }
    }
  }
}

#Preview {
  UpcomingMoviesView(viewModel: MoviesViewModel(useCase: MoviesUseCase(repository: MoviesRepository(apiclient: MoviesAPIClient()))))
}
