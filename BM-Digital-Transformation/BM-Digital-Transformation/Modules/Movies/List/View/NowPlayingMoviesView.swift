//
//  NowPlayingMoviesView.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import SwiftUI

struct NowPlayingMoviesView: View {
  // MARK: - Dependencies
  private let viewModel: MoviesViewModel
  
  // MARK: - Init Methods
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
      }.navigationTitle("Now Playing Movies")
    }.onAppear() {
      Task {
        try await viewModel.startFetchingMovies(with: .nowPlaying)
      }
    }
  }
}

#Preview {
  NowPlayingMoviesView(viewModel: MoviesViewModel(useCase: MoviesUseCase(repository: MoviesRepository(apiclient: MoviesAPIClient()))))
}
