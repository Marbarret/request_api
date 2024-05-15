import SwiftUI

class ViewModel: ObservableObject {
    @Published private(set) var movies: [MovieModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    
    private let movieService: NetworkService
    
    init(movieService: NetworkService) {
        self.movieService = movieService
    }
    
    func fetchMovies() async {
        isLoading = true
        defer { isLoading = false }
        do {
            movies = try await movieService.getRatedMovie()
        } catch {
            print(error.localizedDescription)
        }
    }
}
