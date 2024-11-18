//
//  BM_Digital_TransformationApp.swift
//  BM-Digital-Transformation
//
//  Created by Fady Ramzy on 14/11/2024.
//

import SwiftUI
import SwiftData

@main
struct BM_Digital_TransformationApp: App {
  
    var body: some Scene {
      WindowGroup {
        MoviesContentView(viewModel: MoviesConfigurator().viewModel)
      }
    }
}
