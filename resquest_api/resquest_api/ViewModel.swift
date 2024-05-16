import SwiftUI

class ViewModel: ObservableObject {
    @Published private(set) var movies: [MovieModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    
    private let movieService: NetworkService
    
    init(movieService: NetworkService) {
        self.movieService = movieService
    }
    
    @MainActor
    func getMovies(page: Int) async {
        do {
            movies = try await movieService.fetchData(page: page)
        } catch {
            print(error.localizedDescription)
        }
    }
}
