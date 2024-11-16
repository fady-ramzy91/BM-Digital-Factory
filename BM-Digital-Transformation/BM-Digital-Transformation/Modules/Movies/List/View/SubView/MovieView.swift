//
//  MovieView.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 15/11/2024.
//

import SwiftUI

struct MovieView: View {
  private let movie: MovieUIModel
  
  init(movie: MovieUIModel) {
    self.movie = movie
  }
  
  var body: some View {
    LazyVStack(alignment: .leading) {
      AsyncImage(url: movie.imgaeURL) { image in
        image
          .resizable()
          .scaledToFit()
          .cornerRadius(5)
      } placeholder: {
        ProgressView()
          .frame(maxWidth: .infinity,
                 maxHeight: .infinity)
      }
      HStack {
        VStack(alignment: .leading) {
          Text(movie.title)
            .font(.title)
            .bold()
          Text(movie.releaseDate)
            .font(.title)
        }
      }
    }
  }
}
