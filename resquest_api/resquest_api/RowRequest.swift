//
//  RowRequest.swift
//  resquest_api
//
//  Created by Marcy Barreto on 15/05/24.
//

import SwiftUI

struct RowRequest: View {
    var movie: MovieModel
    
    var body: some View {
        VStack {
            Text(movie.title ?? "")
                .font(.caption)
            Text(movie.releaseDate ?? "")
                .font(.callout)
        }
    }
}
