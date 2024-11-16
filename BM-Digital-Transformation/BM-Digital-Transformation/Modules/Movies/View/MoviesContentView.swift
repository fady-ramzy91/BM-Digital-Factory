//
//  MoviesContentView.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import SwiftUI

struct MoviesContentView: View {
  private let viewModel: MoviesViewModel
  
  init(viewModel: MoviesViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    TabView {
      NowPlayingMoviesView(viewModel: viewModel)
        .tabItem {
          Label("Now Playing",
                systemImage: "list.dash")
      }
      
      UpcomingMoviesView(viewModel: viewModel)
        .tabItem {
          Label("Upcoming",
                systemImage: "list.dash")
        }
      
      PopularMoviesView(viewModel: viewModel)
        .tabItem {
          Label("Popular",
                systemImage: "list.dash")
        }
    }
  }
}

#Preview {
  MoviesContentView(viewModel: MoviesViewModel(useCase: MoviesUseCase(repository: MoviesRepository(apiclient: MoviesAPIClient()))))
}
