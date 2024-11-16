//
//  NowPlayingMoviesView.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import SwiftUI

struct NowPlayingMoviesView: View {
  private let viewModel: MoviesViewModel
  
  init(viewModel: MoviesViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
        NavigationStack {
          List {
            ForEach(viewModel.movies) { movie in
              MovieView(movie: movie)
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
