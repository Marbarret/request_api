//
//  ContentView.swift
//  resquest_api
//
//  Created by Marcy Barreto on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.movies) { movie in
            RowRequest(movie: movie)
        }
        .onAppear {
            Task {
                await viewModel.getMovies(page: 1)
            }
        }
    }
}
