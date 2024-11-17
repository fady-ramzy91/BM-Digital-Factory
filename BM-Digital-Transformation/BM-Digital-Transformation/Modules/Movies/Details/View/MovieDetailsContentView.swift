//
//  MovieDetailsContentView.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 16/11/2024.
//

import SwiftUI

struct MovieDetailsContentView: View {
  // MARK: - Dependencies
  private let movieDetailsViewModel: MoviewDetailsViewModel
  
  // MARK: - Init Method
  init(movieDetailsViewModel: MoviewDetailsViewModel) {
    self.movieDetailsViewModel = movieDetailsViewModel
  }
  
  var body: some View {
    ScrollView {
      ZStack(alignment: .bottomLeading) {
        AsyncImage(url: movieDetailsViewModel.movieDetailsUIModel?.imgaeURL) { image in
          image
            .resizable()
            .scaledToFit()
            .cornerRadius(5)
          
        } placeholder: {
          ProgressView()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
        }
      }
      VStack(alignment: .leading, spacing: 16.0) {
        Text(movieDetailsViewModel.movieDetailsUIModel?.title ?? "")
          .font(.title)
          .bold()
          .padding([.leading, .trailing], 16.0)
        
        Text(movieDetailsViewModel.movieDetailsUIModel?.releaseDate ?? "")
          .font(.title2)
          .padding([.leading, .trailing], 16.0)
        
        VStack(alignment: .leading) {
          Text("Genres")
            .font(.title2)
            .bold().padding([.leading, .trailing], 16.0)
          ForEach(movieDetailsViewModel.movieDetailsUIModel?.genres ?? []) { genre in
            Text(genre.name)
              .font(.title2)
              .padding([.leading, .trailing], 16.0)
          }
        }
        Text(movieDetailsViewModel.movieDetailsUIModel?.runtime ?? "")
          .font(.title2)
          .padding([.leading, .trailing], 16.0)
        Text(movieDetailsViewModel.movieDetailsUIModel?.overview ?? "")
          .font(.title3)
          .padding([.leading, .trailing], 16.0)
      }
    }.onAppear {
      Task {
        try await movieDetailsViewModel.startFetchingMovieDetails()
      }
    }
  }
}

#Preview {
  MovieDetailsContentView(movieDetailsViewModel: MovieDetailsConfigurator(movieId: 912649).viewModel)
}
